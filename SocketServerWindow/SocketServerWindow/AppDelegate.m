//
//  AppDelegate.m
//  SocketServerWindow
//
//  Created by zzzili on 13-6-23.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    server = [[SocketServer alloc]init];
    server.delegate = self;
    // Insert code here to initialize your application
   
}
- (IBAction)SendMessageToClient:(id)sender {
    [server SendMessage];
}

- (IBAction)touchStartServer:(id)sender {
    NSThread *InitThread = [[NSThread alloc]initWithTarget:self selector:@selector(InitThreadFunc:) object:self];
    [InitThread start];
    self.textField.stringValue = @"服务启动成功";
}
-(void)InitThreadFunc:(id)sender
{
    [server StartServer];
}
-(void)ShowMsg:(NSString*)strMsg
{
    NSLog(strMsg);
    self.textField.stringValue = [NSString stringWithFormat:@"%@\n%@",self.textField.stringValue, strMsg];
}
@end
