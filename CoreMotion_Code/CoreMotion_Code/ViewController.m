//
//  ViewController.m
//  CoreMotion_Code
//
//  Created by  baohukeji-5 on 15/1/15.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong)CMMotionManager *cmMg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建motion管理者
    CMMotionManager *cmMg = [[CMMotionManager alloc] init];
    self.cmMg = cmMg;
    
    // 判断是否有加速计功能
    if ([cmMg isAccelerometerAvailable]) {
        // pull 采集方式
        [self pullType];
    }
    
}

/*! pull采集一次  push 一直采集 */
- (void)pullType
{
    // 开始pull采集
    [self.cmMg startAccelerometerUpdates];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 开始获取数据
    CMAcceleration acceleration = self.cmMg.accelerometerData.acceleration;
    NSLog(@"x = %f,y = %f,z = %f",acceleration.x,acceleration.y,acceleration.z);
}

- (void)pushType
{

    // 2. 判断加速计是否可用
    if (self.cmMg.isAccelerometerAvailable)
    {
        NSLog(@"加速剂可用");
        // 3.设置采集间隔
        self.cmMg.accelerometerUpdateInterval = 1 / 2.0;

        // 4.开始采集 (push 的方式)
        [self.cmMg startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            NSLog(@"%f,%f,,%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
            
        }];
        
    }else
    {
        NSLog(@"加速计不可用");
    }
}

@end
