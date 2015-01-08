//
//  ViewController.m
//  NSScream_CFSCream_Code
//
//  Created by  baohukeji-5 on 15/1/6.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initNetworkCommunication
{
    CFReadStreamRef readStream;     // 输入流对象
    CFWriteStreamRef wtriteStream;  // 输出流对象
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"127.0.0.1", kPort, &readStream, &wtriteStream);    //<1>
    
    _inputStream = (__bridge NSInputStream *)(readStream);     //CF 转 NS 类型
    _outputStream = (__bridge NSOutputStream *)(wtriteStream); //CF 转 NS 类型
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];    // 放入NSRunLoop中
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];    // 放入NSRunLoop中
    
    [_inputStream open];   // 打开输入流
    [_outputStream open];  // 打开输出流
    
    /* <1> 说明
     CFStreamCreatePairWithSocketToHost(
     CFAllocatorRef alloc,           内存分配方式
     CFStringRef host,               服务器IP地址
     UInt32 port,                    服务端端口
     CFReadStreamRef *readStream,    返回的输入流对象
     CFWriteStreamRef *writeStream   返回的输出流对象
     )
     */
    
}

- (IBAction)sendBtnAction:(UIButton *)sender {
    flag = 0;  // 发数据
    [self initNetworkCommunication];
    
}

- (IBAction)receiveBtnAction:(UIButton *)sender {
    flag = 1;  // 接收数据
    [self initNetworkCommunication];
}

#pragma mark - NSStreamDelegate方法

/*  (NSStreamEvent)eventCode  流事件是枚举
 
 NSStreamEventNone = 0,                       // 没有事件发生
 NSStreamEventOpenCompleted = 1UL << 0,       // 成功打开流
 NSStreamEventHasBytesAvailable = 1UL << 1,   // 这个流有有数据可以读,在读取数据的时侯使用
 NSStreamEventHasSpaceAvailable = 1UL << 2,   // 这个流可以读取数据的写入,再写入时使用
 NSStreamEventErrorOccurred = 1UL << 3,       // 流发生错误
 NSStreamEventEndEncountered = 1UL << 4       // 流结束
 
 */

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSString *event;
    switch (eventCode) {
            
        case NSStreamEventNone:
            event = @"没有事件";
            break;
            
        case NSStreamEventOpenCompleted:
            event = @"成功打开流";
            break;
            
        case NSStreamEventHasBytesAvailable:
            event = @"有数据,读";
            if(flag == 1 && aStream == _inputStream)
            {
                NSMutableData *inputData = [[NSMutableData alloc] init];  // 设置可变的数据,接收数据
                uint8_t buffer[1024];   // 设置缓存数据
                NSUInteger len;
                while ([_inputStream hasBytesAvailable]) { // 判断是否有流如果有流就循环读取
                    
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        [inputData appendBytes:buffer length:len];
                    }
                }
                NSString *str = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
                _messageLabel.text = str;
            }
            break;
            
        case NSStreamEventHasSpaceAvailable:
            event = @"写入数据";
            
            if(flag == 0 && aStream == _outputStream)
            {
                UInt8 buffer[] = "this is client";
                [_outputStream write:buffer maxLength:strlen((const char*)buffer +1)]; // 写入方法
                //必须关闭输出流否则，服务器端一直读取不会停止，
                [_outputStream close];
            }
            
            break;
        case NSStreamEventEndEncountered:
            event = @"NSStreamEventEndEncountered";
            NSLog(@"Error:%ld:%@",(long)[[aStream streamError] code], [[aStream streamError] localizedDescription]);
            break;
        default:
            [self close];
            event = @"Unknown";
            break;
    }
    NSLog(@"event------%@",event);
}

-(void)close
{
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream setDelegate:nil];
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream setDelegate:nil];
}

@end

