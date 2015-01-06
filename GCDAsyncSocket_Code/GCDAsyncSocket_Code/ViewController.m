//
//  ViewController.m
//  GCDAsyncSocket_Code
//
//  Created by  baohukeji-5 on 15/1/5.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    GCDAsyncSocket *socket;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)coonetButAction:(UIButton *)sender {
    
    // 1. 初始化scoket
    socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    // 2. 配置scoket的服务器地址和端口
    NSError *error = nil;
    if (![socket connectToHost:@"127.0.0.1" onPort:4000 error:&error]) {
        
        NSLog(@"error = %@",error);
        
    }else
    {
        NSLog(@"存在IP和端口");
    }
    
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    NSLog(@"host = %@,port = %d",host,port);
    
    // 3. 连接成功后开始读取,读取后有数据会调用read的代理方法
    // - (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
    
    [socket readDataWithTimeout:-1 tag:0];
    
   // [socket readDataToLength:1024 withTimeout:-1 tag:2];
    
    /**
     * Reads the given number of bytes. 第一个参数:给读取的字节
     *
     * If the timeout value is negative, the read operation will not use a timeout.
     *  第二个参数: 如果超时的值一个负数,读取操作将不使用超时
     * If the length is 0, this method does nothing and the delegate is not called.
     第三个参数: 如果为0,这个方法什么都不做和代理方法也不会被回掉
     **/
    
    /*
     这样读请求会自动进入了队列,当socket 连接上后,请求会自动出队被执行。(这里假设先读一个包头,再根据长度接收包体，这个读操作完成后 socket:didReadData:withTag: 会被调用)
     */
    /*当然我们可以投递多个读写操作而不必等待上一个完成.*/
    
}


// 4.读取另一端发送的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str = %@",str);
    [socket readDataWithTimeout:-1 tag:0];
}


// 5. 写入操作
- (IBAction)writeBtnAction:(UIButton *)sender {
    
    NSData *data = [@"clientMessage" dataUsingEncoding:NSUTF8StringEncoding];
    // 写入到服务端
    [socket writeData:data withTimeout:-1 tag:0];
    [socket readDataWithTimeout:-1 tag:0];
}

@end
