//
//  ViewController.m
//  CoreLocation_Code
//
//  Created by  baohukeji-5 on 15/1/5.
//  Copyright (c) 2015年 ruian. All rights reserved.
//SocketServerWindow 

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>  // 导入框架

@interface ViewController () <CLLocationManagerDelegate>  // 实现 CLLocationManager 的代理

@property (nonatomic, strong) CLLocationManager *clmg;
- (IBAction)locationBtnAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1. 创建定位管理
    [self createLocationManager];
    
    // 4. 计算两个位置的距离
    [self diatance];
}


- (CLLocationManager *)createLocationManager{
    if (!_clmg) {
        self.clmg = [[CLLocationManager alloc] init];
        // 设置CLLocationManager 的代理
        self.clmg.delegate = self;
        self.clmg.distanceFilter = kCLDistanceFilterNone; //默认 每隔多少米更新一次
        self.clmg.desiredAccuracy =  kCLLocationAccuracyBest; // 默认
    }
    return self.clmg;

}

- (IBAction)locationBtnAction:(UIButton *)sender {

    // 2. 开始更新位置
    [self.clmg startUpdatingLocation];
}

// 3. 开始跟新后实现代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = locations.lastObject;
    
    NSLog(@"altitude = %f",location.altitude);   // 海拔
    NSLog(@"course = %f",location.course);       // 路线，航向（取值范围是0.0° ~ 359.9°，0.0°代表真北方向）
    NSLog(@"speed = %f",location.speed);         // 海拔
    NSLog(@"latitude = %f,longitude = %f",location.coordinate.latitude,location.coordinate.longitude); // 经纬度
    
    // 停止更新位置
    [self.clmg stopUpdatingLocation];
}

// 4. 计算两个位置的距离
- (void)diatance
{
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:40 longitude:116];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:41 longitude:116];

    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"distance = %f",distance);
}


@end
