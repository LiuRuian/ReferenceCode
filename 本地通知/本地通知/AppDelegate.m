//
//  AppDelegate.m
//  本地通知
//
//  Created by  baohukeji-5 on 14/12/8.
//  Copyright (c) 2014年 ruian. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 获取是否有通知
    UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 200, 40)];
    label.backgroundColor = [UIColor redColor];
    
    if (localNotification) {
        
        label.text = @"通知进入程序";
        ViewController *vc = self.window.rootViewController.childViewControllers.firstObject;
        [vc performSegueWithIdentifier:@"pushToDetailVC" sender:localNotification];
        
    }else
    {
        label.text = @"点击图标进入程序";
    }
    
    self.label = label;
    [[[self.window.rootViewController.childViewControllers firstObject] view] addSubview:label];
    return YES;
}


// 收到本地通知时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
   /*applicationState 应用的几种状态
    
    UIApplicationStateActive,
    UIApplicationStateInactive,
    UIApplicationStateBackground
    */
   
    if (application.applicationState != UIApplicationStateActive)
    {
        ViewController *vc = self.window.rootViewController.childViewControllers.firstObject;
        
        // 执行 Identifier=pushToDetailVC 的segue
        [vc performSegueWithIdentifier:@"pushToDetailVC" sender:notification];
    }
    self.label.text = @"点击通知进入前台";
   
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
