//
//  ViewController.m
//  AddressBook_Code
//
//  Created by  baohukeji-5 on 15/1/13.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 1.创建通讯录实例
    ABAddressBookRef ab = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 2. 请求访问通讯录的quanx
    ABAddressBookRequestAccessWithCompletion(ab, ^(bool granted, CFErrorRef error) {
        
        if (ab) {
            NSLog(@"允许访问");
            // 允许访问通讯录后调用
            
            // 访问通信录里的属性
            [self accessAddressBook];
        }else{
            NSLog(@"不允许访问");
        }
        
    });
    
    // 释放资源 CoreFoundation
    CFRelease(ab);
}

// 访问通讯录信息
- (void)accessAddressBook
{
    // 1.创建通讯录实例
    ABAddressBookRef ab = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 2.获取所有联系人
    CFArrayRef abPeoplepArray = ABAddressBookCopyArrayOfAllPeople(ab);
    
    // 3. 遍历数组中的所有联系人
    CFIndex count = CFArrayGetCount(abPeoplepArray);
    
    for (CFIndex i = 0; i < count ; i++) {
        // 4. 获取对应索引处的联系人
        ABRecordRef peopleRecord = CFArrayGetValueAtIndex(abPeoplepArray, i);
        
        // 5. 获得联系人的名字
        CFStringRef firstName = ABRecordCopyValue(peopleRecord, kABPersonFirstNameProperty);
        CFStringRef lastName = ABRecordCopyValue(peopleRecord, kABPersonLastNameProperty);
        NSLog(@"%@,%@",lastName,firstName);
        
        // 6.获取联系人的电话
        ABMultiValueRef phone = ABRecordCopyValue(peopleRecord, kABPersonPhoneProperty);
        CFIndex index = ABMultiValueGetCount(phone);
        
        for (int i = 0; i < index; i++) {
            
            CFStringRef phoneLable = ABMultiValueCopyLabelAtIndex(phone, i);
            CFStringRef phoneNum = ABMultiValueCopyValueAtIndex(phone, i);
            
            NSLog(@"phoneLable = %@,phoneNum = %@",phoneLable,phoneNum);
        }
        
        // release 释放
        CFRelease(firstName);
        CFRelease(lastName);
        CFRelease(phone);
    }
    
    CFRelease(ab);
    CFRelease(abPeoplepArray);
    
}

@end
