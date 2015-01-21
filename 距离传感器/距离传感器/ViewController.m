//
//  ViewController.m
//  距离传感器
//
//  Created by  baohukeji-5 on 15/1/14.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*! 开启距离传感器*/
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    /* 设置通知, 监听 UIDeviceProximityStateDidChangeNotification */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

/*! 获得通知*/
- (void)proximityStateDidChange:(NSNotification *)notification
{
    
    if ([UIDevice currentDevice].proximityMonitoringEnabled  == YES) {
        NSLog(@"靠近手机屏幕");
    }else
    {
        NSLog(@"远离手机屏幕");
    }
}

@end
