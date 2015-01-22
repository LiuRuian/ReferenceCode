//
//  ViewController.m
//  AddressBookUI
//
//  Created by  baohukeji-5 on 15/1/14.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>
- (IBAction)displayPeopleAction:(UIButton *)sender;

@property (nonatomic, strong) ABPeoplePickerNavigationController *peoplePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)displayPeopleAction:(UIButton *)sender {
    
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    [self presentViewController:peoplePicker animated:YES completion:nil];
    
}

// 当选中某个联系人的时候就会调用

/*
 // Property keys
 AB_EXTERN const ABPropertyID kABPersonFirstNameProperty;          // First name - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonLastNameProperty;           // Last name - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonMiddleNameProperty;         // Middle name - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonPrefixProperty;             // Prefix ("Sir" "Duke" "General") - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonSuffixProperty;             // Suffix ("Jr." "Sr." "III") - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonNicknameProperty;           // Nickname - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonFirstNamePhoneticProperty;  // First name Phonetic - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonLastNamePhoneticProperty;   // Last name Phonetic - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonMiddleNamePhoneticProperty; // Middle name Phonetic - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonOrganizationProperty;       // Company name - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonJobTitleProperty;           // Job Title - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonDepartmentProperty;         // Department name - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonEmailProperty;              // Email(s) - kABMultiStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonBirthdayProperty;           // Birthday associated with this person - kABDateTimePropertyType
 AB_EXTERN const ABPropertyID kABPersonNoteProperty;               // Note - kABStringPropertyType
 AB_EXTERN const ABPropertyID kABPersonCreationDateProperty;       // Creation Date (when first saved)
 AB_EXTERN const ABPropertyID kABPersonModificationDateProperty;   // Last saved date
 
 // Addresses
 AB_EXTERN const ABPropertyID kABPersonAddressProperty;            // Street address - kABMultiDictionaryPropertyType
 */

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    // 获取联系人的姓名
    CFStringRef firstname = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"name = %@, LastName = %@",firstname,lastName);
    
    // 获取联系人的电话有多个电话
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetCount(phone);
    
    for (int i =0; i < index; i++) {
        
        NSLog(@"电话的类型: %@",ABMultiValueCopyLabelAtIndex(phone, i));  //
        NSLog(@"电话号码: %@",ABMultiValueCopyValueAtIndex(phone, i));
    }
    
    NSLog(@"当选中某个联系人");
    CFRelease(firstname);
    CFRelease(lastName);
    CFRelease(phone);
}


// 当选中某个联系人属性的时候就会调用
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    NSLog(@"当选中某个联系人属性");
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //[peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
//{
//    NSLog(@"当选中某个联系人");
//    return YES;
//}
//
//// Deprecated, use predicateForSelectionOfProperty and/or -peoplePickerNavigationController:didSelectPerson:property:identifier: instead.
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
//{
//     NSLog(@"当选中某个联系人属性");
//    return YES;
//}
@end
