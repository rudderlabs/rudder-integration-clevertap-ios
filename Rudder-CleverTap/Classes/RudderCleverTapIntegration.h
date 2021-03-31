//
//  RudderCleverTapFactory.h
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/21.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>

NS_ASSUME_NONNULL_BEGIN

@interface RudderCleverTapIntegration : NSObject<RSIntegration>

-(instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig*) rudderCinfig;

@end

NS_ASSUME_NONNULL_END
