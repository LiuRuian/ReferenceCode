//
//  AppDelegate.m
//  CLGeocoder 地理编码和反编码
//
//  Created by  baohukeji-5 on 15/1/8.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 300, 500)];
////    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
////    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 300, 40)];
////    self.label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 300, 40)];
////    self.label5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 40)];
////    self.label6 = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 300, 40)];
//    self.label1 = label;
//    _str = [[NSMutableString alloc] initWithFormat:@" FinishLaunching"];
//    label.numberOfLines = 0;
//    label.text = self.str;
//    
//    [self.window.rootViewController.view addSubview:self.label1];
////    [self.window.rootViewController.view addSubview:self.label2];
////    [self.window.rootViewController.view addSubview:self.label3];
////    [self.window.rootViewController.view addSubview:self.label4];
////    [self.window.rootViewController.view addSubview:self.label5];
////    [self.window.rootViewController.view addSubview:self.label6];
//    
//    NSLog(@"FinishLaunching");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

//    [self.str appendString:@" WillResignActive"];
//    self.label1.text = self.str;
//    
//    NSLog(@"WillResignActive");
//    NSLog(@"%@",self.str);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

//    [self.str appendString:@" EnterBackground"];
//    self.label1.text = self.str;
//    NSLog(@"EnterBackground");
//    NSLog(@"%@",self.str);
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
//    [self.str appendString:@" EnterForeground"];
//    //[self.str stringByAppendingString:@"\n EnterForeground"];
//    self.label1.text = self.str;
//    
//    NSLog(@"EnterForeground");
//    NSLog(@"%@",self.str);
//    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [self.str appendString:@" BecomeActive"];
//    self.label1.text = self.str;
//
//    NSLog(@"BecomeActive");
//    NSLog(@"%@",self.str);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.str appendString:@" WillTerminate"];

   // self.str = [self.str stringByAppendingString:@"\n WillTerminate"];
//    self.label1.text = self.str;
//    NSLog(@"WillTerminate");
//    NSLog(@"%@",self.str);
}

@end
