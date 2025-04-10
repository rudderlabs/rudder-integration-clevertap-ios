//
//  RudderCleverTapFactory.h
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/21.
//

#import "RudderCleverTapIntegration.h"

#if defined(COCOAPODS)
// Below import is for the Rudder React Native CleverTap device mode.
#if defined(__has_include) && __has_include(<CleverTap-iOS-SDK/CleverTap.h>)
#import <CleverTap-iOS-SDK/CleverTap.h>
#else
#import <CleverTapSDK/CleverTap.h>
#endif
#endif

@implementation RudderCleverTapIntegration

#pragma mark - Initialization

- (instancetype) initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig *)rudderConfig {
    self = [super init];
    if (self) {
        self.accountId = [config objectForKey:@"accountId"];
        self.accountToken = [config objectForKey:@"accountToken"];
        self.region = [config objectForKey:@"region"];
        self.logLevel = [rudderConfig logLevel];
        if(self.accountId !=nil && self.accountToken != nil) {
            if(![self.region isEqualToString: @"none"]) {
                [CleverTap setCredentialsWithAccountID:self.accountId token:self.accountToken region:self.region];
            }
            else {
                [CleverTap setCredentialsWithAccountID:self.accountId andToken:self.accountToken];
            }
            
            [[CleverTap sharedInstance] notifyApplicationLaunchedWithOptions:nil];
            if(self.logLevel == RSLogLevelDebug) {
                [CleverTap setDebugLevel:CleverTapLogDebug];
            } else if (self.logLevel == RSLogLevelNone) {
                [CleverTap setDebugLevel:CleverTapLogOff];
            } else {
                [CleverTap setDebugLevel:CleverTapLogInfo];
            }
            
            [RSLogger logDebug:@"Initializing CleverTap SDK"];
        }
        else {
            [RSLogger logWarn:@"Failed to Initialize CleverTap Factory"];
        }
        
    }
    return self;
}

- (void)dump:(RSMessage *)message {
    [self processRudderEvent:message];
}

- (void)reset {
    [RSLogger logDebug:@"Inside reset"];
}

- (void)flush { 
    
}


- (void)processRudderEvent:(nonnull RSMessage *)message {
    NSString *type = message.type;
    if([type isEqualToString:@"identify"]) {
        NSMutableDictionary *traits = [message.context.traits mutableCopy];
        NSMutableDictionary *profile = [[NSMutableDictionary alloc] init];
        NSString *userId     = message.userId;
        if (traits[@"userId"]) {
            profile[@"Identity"] = userId;
            [traits removeObjectForKey:@"userId"];
        }
        
        if (traits[@"email"]) {
            profile[@"Email"] = traits[@"email"];
            [traits removeObjectForKey:@"email"];
        }
        
        if (traits[@"name"]) {
            profile[@"Name"] = traits[@"name"];
            [traits removeObjectForKey:@"name"];
        }
        
        if (traits[@"phone"]) {
            profile[@"Phone"] = [NSString stringWithFormat:@"%@", traits[@"phone"]];
            [traits removeObjectForKey:@"phone"];
        }
        
        if ([traits[@"gender"] isKindOfClass:[NSString class]]) {
            NSString *gender = traits[@"gender"];
            if ([gender.lowercaseString isEqualToString:@"male"] || [gender.lowercaseString isEqualToString:@"m"]) {
                profile[@"Gender"] = @"M";
            }
            else if ([gender.lowercaseString isEqualToString:@"female"] || [gender.lowercaseString isEqualToString:@"f"]) {
                profile[@"Gender"] = @"F";
            }
            [traits removeObjectForKey:@"gender"];
        }
        
        if ([traits[@"birthday"] isKindOfClass:[NSString class]]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            [dateFormatter setLocale:enUSPOSIXLocale];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            profile[@"DOB"] = [dateFormatter dateFromString:traits[@"birthday"]];
            [traits removeObjectForKey:@"birthday"];
        }
        else if ([traits[@"birthday"] isKindOfClass:[NSDate class]]) {
            profile[@"DOB"] = traits[@"birthday"];
            [traits removeObjectForKey:@"birthday"];
        }
        
        // Only Primitive types, Date, Address,Company Objects, String arrays are accepted
        for (NSString *key in traits.allKeys) {
            id value = traits[key];
            if (![value isKindOfClass:[NSDictionary class]]) {
                profile[key] = value;
                continue;
            }
            if([key isEqualToString:@"adderess"] || [key isEqualToString:@"address"] || [key isEqualToString:@"company"] ) {
                NSMutableDictionary *nestedMap = [value mutableCopy];
                for (NSString *nestedMapKey in nestedMap.allKeys) {
                    if([nestedMapKey isEqualToString:@"id"]) {
                        profile[@"companyId"] = nestedMap[nestedMapKey];
                        continue;
                    }
                    if([nestedMapKey isEqualToString:@"name"]) {
                        profile[@"companyName"] = nestedMap[nestedMapKey];
                        continue;
                    }
                    profile[nestedMapKey] = nestedMap[nestedMapKey];
                }
                continue;
            }
        }
        
        [[CleverTap sharedInstance] onUserLogin:profile];
        
    }
    else if([type isEqualToString:@"track"]) {
       
        NSString *eventName = message.event;
        if([eventName isEqualToString:@"Order Completed"]) {
            [self handleEcommerceEvent:message];
        }
        else {
            NSDictionary *eventProperties = message.properties;
            if(eventProperties) {
                [[CleverTap sharedInstance] recordEvent:eventName withProps:eventProperties];
            }
            else {
                [[CleverTap sharedInstance] recordEvent:eventName];
            }
        }
    }
    else if ([type isEqualToString:@"screen"]) {
        NSString *screenName = message.event;
        NSDictionary *screenProperties = message.properties;
        if(screenProperties) {
            [[CleverTap sharedInstance] recordEvent:[NSString stringWithFormat:@"Screen Viewed: %@",
                                                     screenName] withProps:screenProperties];
        }
        else {
            [[CleverTap sharedInstance] recordEvent:[NSString stringWithFormat:@"Screen Viewed: %@",
                                                     screenName]];
        }
    }
    else {
        [RSLogger logDebug:@"CleverTap Integration: Message type not supported"];
    }
    
}

#pragma mark- Push Notification methods

- (void)registeredForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [RSLogger logDebug:@"registering for remote notifications"];
    [[CleverTap sharedInstance] setPushToken:deviceToken];
}

- (void)receivedRemoteNotification:(NSDictionary *)userInfo {
    [RSLogger logDebug:@"received remote notification"];
    [[CleverTap sharedInstance] handleNotificationWithData:userInfo];
}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo {
    [RSLogger logDebug:@"handling action with identifier"];
    [[CleverTap sharedInstance] handleNotificationWithData:userInfo];
}

#pragma mark - Utils

- (void)handleEcommerceEvent:(RSMessage *)message {
    NSDictionary *eventProperties = message.properties;
    if (eventProperties == nil) {
        return;
    }
    
    NSMutableDictionary *chargeDetails = [NSMutableDictionary new];
    NSArray *items = [NSArray new];
    
    for (NSString *key in eventProperties.allKeys) {
        id value = eventProperties[key];
        if ([key isEqualToString:@"products"]) {
            if (value != nil && [value isKindOfClass:[NSArray class]]) {
                NSArray *_products = (NSArray*) value;
                if ([_products count] > 0) {
                    items = [self getProductList:_products];
                }
            }
        }
        else if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
            continue;
        }
        else if ([key isEqualToString:@"order_id"]) {
            chargeDetails[@"Charged ID"] = value;
        }
        else if ([key isEqualToString:@"revenue"]) {
            chargeDetails[@"Amount"] = value;
        }
        else {
            chargeDetails[key] = value;
        }
    }
    
    [[CleverTap sharedInstance] recordChargedEventWithDetails:chargeDetails andItems:items];
}

- (NSArray*)getProductList:(NSArray*)products {
    NSMutableArray *transformedProducts = [[NSMutableArray alloc] init];
    for(NSDictionary <NSString *, id>*product in products) {
        NSMutableDictionary *transformedProduct = [[NSMutableDictionary alloc] init];
        [product enumerateKeysAndObjectsUsingBlock:^(NSString  * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:@"product_id"]) {
                [transformedProduct setObject:obj forKey:@"id"];
            } else {
                [transformedProduct setObject:obj forKey:key];
            }
        }];
        [transformedProducts addObject:transformedProduct];
    }
    return transformedProducts;
}

@end
