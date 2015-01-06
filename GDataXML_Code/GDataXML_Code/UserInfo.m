//
//  UserInfo.m
//  NSXMLParser_Code
//
//  Created by  baohukeji-5 on 15/1/4.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)userWitnDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
