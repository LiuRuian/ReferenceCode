//
//  UserInfo.h
//  NSXMLParser_Code
//
//  Created by  baohukeji-5 on 15/1/4.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)userWitnDict:(NSDictionary *)dict;

@end
