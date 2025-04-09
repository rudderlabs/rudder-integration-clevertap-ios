//
//  RudderCleverTapFactory.h
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/21.
//

#import <Foundation/Foundation.h>

#if defined(__has_include) && __has_include(<Rudder/Rudder.h>)
#import <Rudder/Rudder.h>
#else
#import "Rudder.h"
#endif

// Below import is for the Rudder React Native CleverTap device mode.
#if defined(__has_include) && __has_include(<CleverTap-iOS-SDK/CleverTap.h>)
#import <CleverTap-iOS-SDK/CleverTap.h>
#else
#import "CleverTapSDK/CleverTap.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface RudderCleverTapIntegration : NSObject<RSIntegration>

@property (nonatomic) NSString *accountId;
@property (nonatomic) NSString *accountToken;
@property (nonatomic) NSString *region;
@property (nonatomic) int logLevel;

-(instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig*) rudderCinfig;
- (void)registeredForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)receivedRemoteNotification:(NSDictionary *)userInfo;
- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
