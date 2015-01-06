//
//  ViewController.m
//  OtherGCDAsyncSocket_Code
//
//  Created by  baohukeji-5 on 15/1/5.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    GCDAsyncSocket *listensocket;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)connetBtnAction:(UIButton *)sender {
    
    // 1. 创建 GCDAsyncSocket
    listensocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    NSError *error = nil;
    // 2. GCDAsyncSocket 创建一个服务器,并接受传入的连接
    if (![listensocket acceptOnPort:4000 error:&error])
    {
        NSLog(@"error: %@", error);
    }else
    {
        NSLog(@"开始监听端口");
    }
    
}



- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    // The "sock" parameter is the listenSocket we created.
    // 这个sock 的参数是一个我们创建的 listensocket
    
    // The "newSocket" is a new instance of GCDAsyncSocket.
    // 这个newSocket是一个新的Socket
    
    // It represents the accepted incoming client connection.
    // 它代表着接受传入的客户端连接
    
    listensocket = newSocket;
    [listensocket readDataWithTimeout:-1 tag:0];
}



// 读取出入的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str = %@",str);
    
    [listensocket readDataWithTimeout:-1 tag:0];
}


- (IBAction)sendMessageBtnAction:(UIButton *)sender {
    
    NSData *data = [@"severMessage" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 写入到服务端
    [listensocket writeData:data withTimeout:-1 tag:0];
    [listensocket readDataWithTimeout:-1 tag:0];
}

@end
