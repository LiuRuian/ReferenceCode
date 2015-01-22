//
//  ViewController.m
//  MotionShake_Code
//
//  Created by  baohukeji-5 on 15/1/15.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 开始摇一摇
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇一摇");
}

// 结束摇一摇
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion !=  UIEventSubtypeMotionShake) return;
       NSLog(@"结束摇一摇");
}

// 摇一摇取消
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇一摇取消");
}
@end
