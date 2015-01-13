//
//  ViewController.m
//  Reachability_Code
//
//  Created by  baohukeji-5 on 15/1/13.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

/*
 
 // 1. 定义网络请求可到达状态
 typedef enum
 {
 NotReachable = 0,   // 不可到达
 ReachableViaWiFi,   // 通过WiFi可到达
 ReachableViaWWAN    // 通过无线广域网可到达(WWAN，即Wireless Wide Area Network，无线广域网。)
 } NetworkStatus;
 
 // 2. 宏定义关于网络连接变更的通知标识名称：
 #define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"
 NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";
 
 // 3. 用于检查网络请求是否可到达指定的主机名
 + (instancetype)reachabilityWithHostName:(NSString *)hostName;
 
 // 4. // 用于检查网络请求是否可到达指定的IP地址
+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;
 
 // 5. // 用于检查路由连接是否有效
 + (instancetype)reachabilityForInternetConnection;

 // 6. 用于检查本地的WiFi连接是否有效
+ (instancetype)reachabilityForLocalWiFi;
 
 // 7. // 在当前程序的运行回路中开始监听网络请求可到达的通知
 - (BOOL) startNotifier;
 - (void) stopNotifier;
 
 // 8. 当前网络请求可到达状态
 - (NetworkStatus)currentReachabilityStatus;
 
 // 9.WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
 
 - (BOOL)connectionRequired;
 */

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()
@property (nonatomic, strong)Reachability *internetStatus;
@end

@implementation ViewController


/* wifi 上网
[wifiStatus currentReachabilityStatus] != NotReachable
[wifiStatus currentReachabilityStatus] != NotReachable

 无wifi,有手机网络
[wifiStatus currentReachabilityStatus] == NotReachable
[internetStatus currentReachabilityStatus] != NotReachable

 无wifi,无手机网络
 [wifiStatus currentReachabilityStatus] == NotReachable
 [internetStatus currentReachabilityStatus] == NotReachable
 
*/
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reachability *internetStatus = [Reachability reachabilityForInternetConnection];
    self.internetStatus = internetStatus;
    
    // 注册通知,当网络网络状态改变的时候发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connetStutasChange) name:kReachabilityChangedNotification object:nil];
    // 开启检测网络,需要将 internetStatus 设为属性
    [internetStatus startNotifier];
    
    [self checkNetStatus];
    
}

- (void)checkNetStatus
{
    // 1. 检查wifi的网络状态
    Reachability *wifiStatus = [Reachability reachabilityForLocalWiFi];
    
    // 2. 检查手机网络状态(非wifi状态)
    Reachability *internetStatus = [Reachability reachabilityForInternetConnection];
 
    if ([wifiStatus currentReachabilityStatus] != NotReachable) {
        NSLog(@"有wifi");
    }else
    {
        NSLog(@"无wifi");
    }
    
    
    if ([internetStatus currentReachabilityStatus] != NotReachable) {
        NSLog(@"手机能网络");
    }else{
        NSLog(@"手机不能网络");
    }
    
    if ([wifiStatus currentReachabilityStatus] != NotReachable) {
        NSLog(@"有wifi");
    }else if ([internetStatus currentReachabilityStatus] != NotReachable) {
        NSLog(@"无wifit ,有手机能网络");
    }else{
        NSLog(@"无wifit ,无手机上网");
    }
}
- (void)connetStutasChange
{
     NSLog(@"连接状态改变");
    
    // 网络状态改变,重新检查网络状态
    [self checkNetStatus];
   
}

@end
