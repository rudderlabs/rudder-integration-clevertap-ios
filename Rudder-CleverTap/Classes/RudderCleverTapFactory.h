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


NS_ASSUME_NONNULL_BEGIN

@interface RudderCleverTapFactory : NSObject<RSIntegrationFactory>
+ (instancetype) instance;

@end

NS_ASSUME_NONNULL_END
