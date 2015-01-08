//
//  ViewController.h
//  NSScream_CFSCream_Code
//
//  Created by  baohukeji-5 on 15/1/6.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define kPort 8888

@interface ViewController : UIViewController <NSStreamDelegate>
{
    int flag;   // 操纵标识 0为发送 1 为接收
}

@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;

// 定义输入流和输出流与服务端的输入和输出相对应

- (IBAction)sendBtnAction:(UIButton *)sender;
- (IBAction)receiveBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
