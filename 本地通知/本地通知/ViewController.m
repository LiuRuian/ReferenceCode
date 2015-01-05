//
//  ViewController.m
//  本地通知
//
//  Created by  baohukeji-5 on 14/12/8.
//  Copyright (c) 2014年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

- (IBAction)addLocalNotification:(UIButton *)sender;
- (IBAction)cancelLocalNotification:(UIButton *)sender;
@property (nonatomic,strong)UILocalNotification *localNotification;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addLocalNotification:(UIButton *)sender {
    
    // 1.创建初始化本地通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
   
    // 2.设置属性
    
    // 2.0 设置启动图片
    localNotification.alertLaunchImage = @"Default";
    
    // 2.1 设置标题, 锁屏状态下显示的下面小标题的滑动来 显示的文字
    localNotification.alertAction = @"友情提示,这是本地通知的标题";
    
    // 2.2 设置通知内容
    localNotification.alertBody = @"这里是本地通知的内容";
    
    // 2.3 设置通知提示的红色气泡数字
    localNotification.applicationIconBadgeNumber = 1;
    
    // 2.4 设置通知的时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:6];
    
    //2.5 设置循环次数0表示不重复
    //localNotification.repeatInterval = kCFCalendarUnitMinute;
    
    // 2.6 设置声音,可以换成其他铃声  alarm.soundName = @"myMusic.caf"
    localNotification.soundName= UILocalNotificationDefaultSoundName;
    
    // 2.7 设置本地时区
    localNotification.timeZone=[NSTimeZone defaultTimeZone];
    
    // 2.8 设置通知的额外信息
    localNotification.userInfo = @{@"icon":@"icon.png",@"title":@"news",@"time":@"2014"};
    
    //3. 添加本地通知
    UIApplication *app = [UIApplication sharedApplication];
    
    // 取消现在的通知
    [app cancelLocalNotification:localNotification];
    
    // 取消所有已有的通知
    [app cancelAllLocalNotifications];
    // 加入新的通知
    [app scheduleLocalNotification:localNotification];
   
    // 当App再后台运行时,可调用此方法可以立即发出通知
    //[app presentLocalNotificationNow:localNotification];
}

- (IBAction)cancelLocalNotification:(UIButton *)sender {
    
    //3. 添加本地通知
    UIApplication *app = [UIApplication sharedApplication];

    // 取消所有已有的通知
    [app cancelAllLocalNotifications];
}


// segue 传入数据UILocalNotification 数据

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UILocalNotification *)note
{
    // 跳转的时候传值
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.localNotification = note;
}

@end
