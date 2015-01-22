//
//  ViewController.m
//  Accelerometer_Code
//
//  Created by  baohukeji-5 on 15/1/15.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

// 在iOS5之后被放弃

#import "ViewController.h"

@interface ViewController ()<UIAccelerometerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置加速计单例
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    
    // 2. 设置加速计代理
    accelerometer.delegate = self;
    
    // 3.设置加速计的采集频率
    accelerometer.updateInterval = 1 / 2.0;

}

/*当采集到加速计数据就会调用此方法*/

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"x= %f, y= %f, z= %f",acceleration.x,acceleration.y,acceleration.z);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"size = %@,coordinator = %@",NSStringFromCGSize(size),coordinator);
    
}

@end
