//
//  ViewController.m
//  AudioToolbox_Code
//
//  Created by  baohukeji-5 on 15/1/17.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>   // 导入音效框架

@interface ViewController ()

@property (nonatomic, assign)SystemSoundID soundID;
- (IBAction)playSoundAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 1.声明声音
    SystemSoundID soundID = 0;
    _soundID = soundID;
    
    // 2. 声音的路径
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"alarmSound" withExtension:@"caf"];
    
    // 3.创建声音
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &_soundID);
}


- (IBAction)playSoundAction:(UIButton *)sender {
    
    // 播放声音加振动
    AudioServicesPlayAlertSound(_soundID);
    // 播放振动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}
@end
