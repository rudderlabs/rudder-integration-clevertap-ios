//
//  RudderCleverTapFactory.h
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/21.
//

#import "RudderCleverTapIntegration.h"
#import <Rudder/Rudder.h>
@implementation RudderCleverTapIntegration

#pragma mark - Initialization

- (instancetype) initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig *)rudderConfig {
    self = [super init];
    if (self) {
        // Initialize the destination sdk here
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
        // implementation for identify
    }
    if([type isEqualToString:@"track"]){
        // implementation for track
    }else if ([type isEqualToString:@"screen"]){
        // implementation for screen
    }else {
        [RSLogger logDebug:@"CleverTap Integration: Message type not supported"];
    }
    
}



@end
