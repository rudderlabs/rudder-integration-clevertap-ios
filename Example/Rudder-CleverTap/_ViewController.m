//
//  _ViewController.m
//  Rudder-CleverTap
//
//  Created by Desu Sai Venkat on 31/03/2021.
//  Copyright (c) 2021 Desu Sai Venkat. All rights reserved.
//

#import "_ViewController.h"
#import <Rudder/Rudder.h>

@interface _ViewController ()

@end

@implementation _ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonTap:(UIButton *)sender {
    switch (sender.tag) {
        case 11: {
            NSDateComponents *dob = [[NSDateComponents alloc] init];
            dob.day = 24;
            dob.month = 5;
            dob.year = 1992;
            NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:dob];
            NSDictionary *profile = @{
                @"name": @"RudderStack iOS",               // String or number
                @"email": @"testuseriOS@example.com",            // Email address of the user
                @"phone": @"+919876543210",              // Phone (with the country code, starting with +)
                @"gender": @"M",                        // Can be either M or F
                @"Employed": @"Y",                      // Can be either Y or N
                @"Education": @"Graduate",              // Can be either Graduate, College or School
                @"Married": @"Y",                       // Can be either Y or N
                @"birthday": d,                              // Date of Birth. An NSDate object
                @"Age": @28,                            // Not required if DOB is set
                @"Tz": @"Asia/Kolkata",                 //an abbreviation such as "PST", a full name such as "America/Los_Angeles",
                //or a custom ID such as "GMT-8:00"
                @"Photo": @"www.foobar.com/image.jpeg",
                @"address": @{
                    @"city": @"Kolkata",
                    @"country": @"India"
                },
                @"key-1": @"value-1",
                @"key-2": @1234
            };
            [[RSClient sharedInstance] identify:@"rudderstack_ios_4" traits:profile];
        }
            break;
        case 0:
            [[RSClient sharedInstance] track:@"Order Completed"];
            break;
        case 1:
            [[RSClient sharedInstance] track:@"Order Completed" properties:@{
                @"revenue": @123,
                @"currency": @"INR",
                @"Key-1": @"Value-1"
            }];
            break;
        case 2:
            [[RSClient sharedInstance] track:@"Order Completed" properties:@{
                @"revenue": @123,
                @"currency": @"INR",
                @"Key-1": @"Value-1",
                @"order_id": @"1234567890"
            }];
            break;
        case 3:
            [[RSClient sharedInstance] track:@"Order Completed" properties:@{
                @"products": @[@{
                    @"product_id": @"1001",
                    @"quantity": @11,
                    @"price": @100.11,
                    @"Product-Key-1": @"Product-Value-1"
                }],
                @"revenue": @123,
                @"currency": @"INR",
                @"Key-1": @"Value-1"
            }];
            break;
        case 4:
            [[RSClient sharedInstance] track:@"Order Completed" properties:@{
                @"products": @[@{
                    @"product_id": @"1001",
                    @"quantity": @11,
                    @"price": @100.11,
                    @"Product-Key-1": @"Product-Value-1"
                }],
                @"revenue": @123,
                @"currency": @"INR",
                @"Key-1": @"Value-1",
                @"order_id": @"1234567890"
            }];
            break;
        case 5:
            [[RSClient sharedInstance] track:@"Order Completed" properties:@{
                @"products": @[
                    @{
                        @"product_id": @"1001",
                        @"quantity": @11,
                        @"price": @100.11,
                        @"Product-Key-1": @"Product-Value-1"
                    },
                    @{
                        @"product_id": @"1002",
                        @"quantity": @5,
                        @"price": @89.11,
                        @"Product-Key-2": @"Product-Value-2"
                    }],
                @"revenue": @123,
                @"currency": @"INR",
                @"Key-1": @"Value-1",
                @"order_id": @"1234567890"
            }];
            break;
        case 6:
            [[RSClient sharedInstance] track:@"New Track event" properties:@{
                @"key_1" : @"value_1",
                @"key_2" : @"value_2"
            }];
            break;
        case 7:
            [[RSClient sharedInstance] track:@"New Track event"];
        case 8:
            [[RSClient sharedInstance] screen:@"Home" properties:@{
                @"key_1" : @"value_1",
                @"key_2" : @"value_2"
            }];
            break;
        case 9:
            [[RSClient sharedInstance] screen:@"Home"];
        default:
            break;
    }
}
@end
