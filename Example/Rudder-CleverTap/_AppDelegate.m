//
//  _AppDelegate.m
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/2021.
//  Copyright (c) 2021 Desu Sai Venkat. All rights reserved.
//

#import "_AppDelegate.h"
#import <Rudder/Rudder.h>
#import <RudderCleverTapFactory.h>
#import "RudderCleverTapIntegration.h"
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>


@implementation _AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    // Override point for customization after application launch.
    NSString *WRITE_KEY = @"1rQzF38dtwHk7n6A196Wmo5pPCw";
    NSString *DATA_PLANE_URL = @"https://6be12a7be9b0.ngrok.io/";
    
    RSConfigBuilder *configBuilder = [[RSConfigBuilder alloc] init];
    [configBuilder withDataPlaneUrl:DATA_PLANE_URL];
    [configBuilder withControlPlaneUrl:@"https://api.dev.rudderlabs.com"];
    [configBuilder withLoglevel:RSLogLevelDebug];
    [configBuilder withFactory:[RudderCleverTapFactory instance]];
    [configBuilder withTrackLifecycleEvens:false];
    [RSClient getInstance:WRITE_KEY config:[configBuilder build]];
    
    // register for push notifications
//    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
//    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge)
//                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^(void) {
//                [[UIApplication sharedApplication] registerForRemoteNotifications];
//            });
//        }
//    }];
    
   
    //TC:1 //Track call only with event name before identify
    //[[RSClient sharedInstance] track:@"Songs Viewed before identify"];

    //TC:2 //Identify call only with userId
   //[[RSClient sharedInstance] identify:@"ankur1"];
//
//    //TC:3 //Identify call with the same userId and update traits
//    [[RSClient sharedInstance] identify:@"ankur1"
//                                 traits:@{@"name": @"Ankur1 Mittal",
//                                          @"pincode": @"713216",
//                                          @"email": @"ankur1@gmail.com",
//                                          @"state" : @"WB",
//                                          @"city" : @"Durgapur",
//                                          @"country": @"India"
//                                 }
//    ];
//
//    //TC:4 //Track call with event name and property after Identify
//    [[RSClient sharedInstance] track:@"Songs Viewed after identify" properties:@{
//        @"details" : @"anything",
//        @"song name" : @"Where r u now"
//    }];
//
//    //TC:5 //Identify with anonymousId, email, and name
//    [[RSClient sharedInstance] identify:@""
//                                 traits:@{@"email": @"ankur2@gmail.com",
//                                          @"name": @"Ankur2 Mittal"
//                                 }
//    ];
//
//    //TC:6 //Screen with identified anonymousId, name and properties
//    [[RSClient sharedInstance] screen:@"ViewController" properties: @{
//        @"url" : @"www.viewcontroller.com",
//        @"path": @"../www"
//    }];
//
//    //TC: 7 //Identify call with userId, email, phone, gender, education, married, employed, name
//    [[RSClient sharedInstance] identify:@"ankur3"
//                                 traits:@{@"name": @"Ankur3 Mittal",
//                                          @"pincode": @"700065",
//                                          @"country": @"India",
//                                          @"state" : @"WB",
//                                          @"city" : @"Durgapur",
//                                          @"email": @"ankur3@gmail.com",
//                                          @"phone": @"+918250294239",
//                                          @"gender": @"M",
//                                          @"Education":@"Graduate",
//                                          @"Employed":@"Y",
//                                          @"Married":@"N"
//
//                                 }
//    ];
//
//    //TC:8 //Identify call with the wrong email and phone number without country code.
//    [[RSClient sharedInstance] identify:@"ankur4"
//                                 traits:@{@"name": @"Ankur4 Mittal",
//                                          @"email": @"ankur4gmail",
//                                          @"phone": @"8260294239"
//
//                                 }
//    ];
//
//    //TC: 9 //Identify call with gender : M/m/Male/male, F/f/Female/female
//
//    [[RSClient sharedInstance] identify:@"ankur5"
//                                 traits:@{@"name": @"Ankur5 Mittal",
//                                          @"gender": @"m"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur6"
//                                 traits:@{@"name": @"Ankur6 Mittal",
//                                          @"gender": @"male"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur7"
//                                 traits:@{@"name": @"Ankur7 Mittal",
//                                          @"gender": @"Male"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur8"
//                                 traits:@{@"name": @"Ankur8 Mittal",
//                                          @"gender": @"F"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur9"
//                                 traits:@{@"name": @"Ankur9 Mittal",
//                                          @"gender": @"f"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur10"
//                                 traits:@{@"name": @"Ankur10 Mittal",
//                                          @"gender": @"female"
//
//                                 }
//    ];
//
//    [[RSClient sharedInstance] identify:@"ankur11"
//                                 traits:@{@"name": @"Ankur11 Mittal",
//                                          @"gender": @"Female"
//
//                                 }
//    ];
//
//    //TC: 10 //Identify call with birthday  : Date/String
//    [[RSClient sharedInstance] identify:@"ankur12"
//                                    traits:@{@"name": @"Ankur12 Mittal",
//                                             @"birthday": @"2020-01-01"
//
//                                    }
//       ];
//    NSDate *date= [NSDate date];
//    [[RSClient sharedInstance] identify:@"ankur13"
//                                 traits:@{@"name": @"Ankur13 Mittal",
//                                          @"birthday": date
//
//                                 }
//    ];
//
//    //TC:11 //Identify call with Array of array/ Array of object/ Object of object/
//    // array of integers/ Array of strings/ simple key value pair(key as a
//    // string and value as int or string).
//
//    //array of array
//    NSArray *arr = @[ @[ @'0', @'1', @'2'],
//    @[ @'0', @'1', @'2']];
    NSArray *myArray1 = @[@"red", @"blue"];
   NSArray *myArray2 = @[@111, @222];
//
//    [[RSClient sharedInstance] identify:@"sumo1"
//                                 traits:@{@"data": arr
//
//                                 }
//    ];
//
//    //Array of object
//    [[RSClient sharedInstance] identify:@"sumo2"
//                                 traits:@{@"data": @[
//                                                  @{
//                                                      @"pro_color": @"Black",
//                                                      @"price" :@1234
//                                                  }
//                                                  ]}
//    ];
//
//    //object of object
//     [[RSClient sharedInstance] identify:@"sumo3"
//                                  traits:@{@"data": @{
//                                                   @"price": @1120,
//                                                   @"products": @{
//                                                           @"color": @"multi"
//                                                   }
//                                  }}
//       ];
//
//    //array of integer
//    [[RSClient sharedInstance] identify:@"sumo4"
//                                 traits:@{@"data": myArray2
//
//                                 }
//    ];
//
//    //array of string
//    [[RSClient sharedInstance] identify:@"sumo5"
//                                 traits:@{@"data": myArray1,
//                                          @"value": @100
//
//                                 }
//    ];
//
//
//
//
//    //TC:12 //Identify call with email
//    [[RSClient sharedInstance] identify:@"ankur14@gmail.com"
//                                   traits:@{@"name": @"Ankur14 Mittal"
//
//                                   }
//      ];
//
//    //TC:13 //Track call with name and properties with array of strings/integers
//
//
//    [[RSClient sharedInstance] track:@"array of strings" properties:@{
//        @"value": myArray1
//       }];
//
//    [[RSClient sharedInstance] track:@"array of integers" properties:@{
//           @"value" : myArray2
//       }];
//
//
//    //TC:14 //Screen call with name
   //[[RSClient sharedInstance] screen:@"Amazon Page"];
//
//
    //TC:15 //Screen call with name, category and property
//    [[RSClient sharedInstance] screen:@"Limeroad Home" properties: @{
//        @"url" : @"www.limeroad.com",
//        @"path": @"../www",
//        @"category": @"Limeroad Category"
//    }];
//
    
    [[RSClient sharedInstance] identify:@"arkoprovo1"];
    [[RSClient sharedInstance] screen:@"Amazon Page"];
    [[RSClient sharedInstance] track:@"Songs Viewed before identify"];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application 
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{
    NSLog(@"PUSH NOTIFICATION GETTING STARTED");
    [[RudderCleverTapIntegration alloc] registeredForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler 
{
    [[RudderCleverTapIntegration alloc] receivedRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler 
{
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler 
{
    [[RudderCleverTapIntegration alloc] receivedRemoteNotification:response.notification.request.content.userInfo];
}

@end
