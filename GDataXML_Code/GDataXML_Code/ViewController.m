//
//  ViewController.m
//  GDataXML_Code
//
//  Created by  baohukeji-5 on 15/1/6.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "UserInfo.h"
#import "UserDetailInfo.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *userInfoArray;
@property (nonatomic, strong) NSMutableArray *userDetailInfoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUserInfoArray];
    [self createUserDetailInfoArray];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userxml" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
    
    // 1. 加载档
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData error:nil];
    
    // 2. 获得根元素
    GDataXMLElement *element = doc.rootElement;
    
    // 3. 获得所有的user的根节点
    NSArray *elementArray = [element elementsForName:@"user"];
    
    for (GDataXMLElement *ele in elementArray) {
        
        // 1. 获取根节点的属性值,用模型接收属性
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.Id = [[ele attributeForName:@"Id"] stringValue];
        userInfo.token = [[ele attributeForName:@"token"] stringValue];
        userInfo.phone = [[ele attributeForName:@"phone"] stringValue];
        [self.userInfoArray addObject:userInfo];
        
        NSLog(@"%@,%@,%@",userInfo.Id,userInfo.token,userInfo.phone);
        
        // 2. 创建模型获取其中的值
        UserDetailInfo *userDetailInfo = [[UserDetailInfo alloc] init];
        
        // 2.1 获取子节点每个元素的值
        GDataXMLElement * usernameElement = [[ele elementsForName:@"username"] lastObject];
        userDetailInfo.username = [usernameElement stringValue];
        
        GDataXMLElement * sexElement = [[ele elementsForName:@"sex"] lastObject];
        userDetailInfo.sex = [sexElement stringValue];
        
        GDataXMLElement * photourlElement = [[ele elementsForName:@"photourl"] lastObject];
        userDetailInfo.photourl = [photourlElement stringValue];
        
        [self.userDetailInfoArray addObject:userDetailInfo];
        
        NSLog(@"%@,%@,%@",userDetailInfo.username,userDetailInfo.sex,userDetailInfo.photourl);
    }
}

- (NSMutableArray *)createUserInfoArray
{
    if (!_userInfoArray) {
        self.userInfoArray = [NSMutableArray new];
    }
    return self.userInfoArray;
}

- (NSMutableArray *)createUserDetailInfoArray
{
    if (!_userDetailInfoArray) {
        self.userDetailInfoArray = [NSMutableArray new];
    }
    return self.userDetailInfoArray;
}

@end
