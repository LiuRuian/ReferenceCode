//
//  AppDelegate.h
//  NSXMLParser_Code
//
//  Created by  baohukeji-5 on 15/1/4.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/*
 目前有两种流行的模式:SAX和DOM
 
 SAX是一种基于事件驱动的解析模式,从根节点开始,按顺序一个一个元素解析,如果遇到开始标签、结束标签和属性等,就会触发相应的事件.
 优点:解析速度快.
 缺点:只能读不能写. 
 适合大文件的解析.
 
 DOM模式将XML文档一次性放入内存,作为一棵树状结构进行分析,获取节点的内容以及相关属性,或是新增、删除和修改节点的内容。
 优点:可以读和写XML文件
 缺点:大文件读取较慢.
 适合小文件解析
 */

@end

