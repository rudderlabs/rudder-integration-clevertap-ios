//
//  RudderCleverTapFactory.h
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/21.
//

#import "RudderCleverTapIntegration.h"
#import <Rudder/Rudder.h>
#import <CleverTapSDK/CleverTap.h>
@implementation RudderCleverTapIntegration

#pragma mark - Initialization

- (instancetype) initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig *)rudderConfig {
    self = [super init];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.accountId = [config objectForKey:@"accountId"];
            self.accountToken = [config objectForKey:@"accountToken"];
            self.region = [config objectForKey:@"region"];
            self.logLevel = [rudderConfig logLevel];
            if(self.accountId !=nil && self.accountToken != nil)
            {
                if(self.region !=nil)
                {
                    [CleverTap setCredentialsWithAccountID:self.accountId token:self.accountToken region:self.region];
                }
                else{
                    [CleverTap setCredentialsWithAccountID:self.accountId andToken:self.accountToken];
                }
                [[CleverTap sharedInstance] notifyApplicationLaunchedWithOptions:nil];
                if(self.logLevel >= RSLogLevelDebug)
                {
                    [CleverTap setDebugLevel:CleverTapLogDebug];
                }
                else{
                    [CleverTap setDebugLevel:CleverTapLogInfo];
                }
                [RSLogger logDebug:@"Initializing CleverTap SDK"];
            }else{
                [RSLogger logWarn:@"Failed to Initialize CleverTap Factory"];
            }
        });
    }
    return self;
}

- (void) dump:(RSMessage *)message {
    @try {
        if (message != nil) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self processRudderEvent:message];
            });
        }
    } @catch (NSException *ex) {
        [RSLogger logError:[[NSString alloc] initWithFormat:@"%@", ex]];
    }
}

- (void)reset {
    [RSLogger logDebug:@"Inside reset"];
}

- (void) processRudderEvent: (nonnull RSMessage *) message {
    NSString *type = message.type;
    if([type isEqualToString:@"identify"]){
        NSMutableDictionary *traits = [message.context.traits mutableCopy];
        NSMutableDictionary *profile = [[NSMutableDictionary alloc] init];
        NSString *userId     = message.userId;
        if(userId && userId.length>0)
        {
            profile[@"Identity"] = userId;
            [traits removeObjectForKey:@"id"];
            
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
                } else if ([gender.lowercaseString isEqualToString:@"female"] || [gender.lowercaseString isEqualToString:@"f"]) {
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
            
            // Only Primitive types, Date Object, String arrays are accepted
            for (NSString *key in traits.allKeys) {
                id value = traits[key];
                if (![value isKindOfClass:[NSDictionary class]]) {
                    profile[key] = value;
                }
            }
            
            [[CleverTap sharedInstance] onUserLogin:traits];
        }
    }
    if([type isEqualToString:@"track"]){
        NSString *eventName = message.event;
        if([eventName isEqualToString:@"Order Completed"])
        {
            [self handleEcommerceEvent:message];
        }
        else{
            NSDictionary *eventProperties = message.properties;
            if(eventProperties)
            {
                [[CleverTap sharedInstance] recordEvent:eventName withProps:eventProperties];
            }
            else{
                [[CleverTap sharedInstance] recordEvent:eventName];
            }
        }
    }else if ([type isEqualToString:@"screen"]){
        NSString *screenName = message.event;
        NSDictionary *screenProperties = message.properties;
        if(screenProperties)
        {
            [[CleverTap sharedInstance] recordEvent:[NSString stringWithFormat:@"Viewed %@ Screen",
                                                     screenName] withProps:screenProperties];
        }
        else{
            [[CleverTap sharedInstance] recordEvent:[NSString stringWithFormat:@"Viewed %@ Screen",
                                                     screenName]];
        }
    }else {
        [RSLogger logDebug:@"CleverTap Integration: Message type not supported"];
    }
    
}

-(void) handleEcommerceEvent:(RSMessage *) message {
       NSMutableDictionary *chargeDetails = [NSMutableDictionary new];
       NSArray *items = [NSArray new];
       
       NSDictionary *eventProperties = message.properties;
       for (NSString *key in eventProperties.allKeys) {
           id value = eventProperties[key];
           if ([key isEqualToString:@"products"]) {
               if (value != nil && [value isKindOfClass:[NSArray class]]) {
                   NSArray *_value = (NSArray*) value;
                   if ([_value count] > 0) {
                       items = (NSArray *)value;
                   }
               }
           } else if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
               continue;
           } else if ([key isEqualToString:@"order_id"]) {
               chargeDetails[@"Charged ID"] = value;
           } else if ([key isEqualToString:@"revenue"]) {
               chargeDetails[@"Amount"] = value;
           } else {
               chargeDetails[key] = value;
           }
       }
       
       [[CleverTap sharedInstance] recordChargedEventWithDetails:chargeDetails andItems:items];
}



@end
