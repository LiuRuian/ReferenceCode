//
//  ViewController.m
//  NSXMLParser_Code
//
//  Created by  baohukeji-5 on 15/1/4.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "UserInfo.h"
#import "UserDetailInfo.h"

@interface ViewController ()<NSXMLParserDelegate>

- (IBAction)startXMLParser:(UIButton *)sender;

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableArray *userInfoAttributeArray;
@property (nonatomic, strong) NSMutableArray *userDetailInfoArray;
@property (nonatomic, copy) NSString *currentElement;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUserInfoAttributeArray];
    
    // 1. 创建XMLParser
    [self createXMLParser];
}

- (NSMutableArray *)createUserInfoAttributeArray
{
    if (!_userInfoAttributeArray) {
        self.userInfoAttributeArray = [[NSMutableArray alloc] init];
    }
    return self.userInfoAttributeArray;
}



- (NSXMLParser *)createXMLParser
{
    if (!_xmlParser) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userxml" ofType:@"xml"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.xmlParser = [[NSXMLParser alloc] initWithData:data];
        self.xmlParser.delegate = self;
    }
    return self.xmlParser;
}

- (IBAction)startXMLParser:(UIButton *)sender {
    
    // 开始解析
    [self.xmlParser parse];
}

// 1.开始解析文档
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析文档");
    _userDetailInfoArray = [NSMutableArray new];
}

// 2.遇到开始标签后,调用此方法.  标签内的属性
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
     _currentElement = elementName;
    
    if ([_currentElement isEqualToString:@"user"]) {
        
        // 此处解析的是标签内的属性  attributeDict 属性为一个字典
        // 2.1 模型 接收标签内的属性值
        UserInfo *info = [UserInfo userWitnDict:attributeDict];
        [self.userInfoAttributeArray addObject:info];
        
        UserDetailInfo *detail = [[UserDetailInfo alloc] init];
        [_userDetailInfoArray addObject:detail];
    }
}

// 3.开始解析一组标签内的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // 3.1 模型 接收标签内的内容
    UserDetailInfo *detail = [_userDetailInfoArray lastObject];
    
    if ([_currentElement isEqualToString:@"username"]) {
        
        detail.username = string;
        
    }else if([_currentElement isEqualToString:@"sex"])
    {
        detail.sex = string;
       
    }else if([_currentElement isEqualToString:@"photourl"])
    {
        detail.photourl = string;
    }
}

// 4. 遇到结束标签后,调用此方法
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // 一组标签解析结束,对element赋值为空,以便解析下组标签时重新赋值
     _currentElement = nil;
}

// 结束解析温度
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // 打印解析后标签内的内容
    for (UserDetailInfo *info in self.userDetailInfoArray) {
        
        NSLog(@"username = %@,sex = %@,photourl = %@",info.username,info.sex,info.photourl);
    }
    
    // 打印解析后的标签内的属性内容
    for (UserInfo *info in self.userInfoAttributeArray) {
        NSLog(@"Id = %@,token = %@,phone = %@",info.Id,info.token,info.phone);
    }
}


// 文档出错时触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
     NSLog(@"parseError = %@",parseError);
}

@end
