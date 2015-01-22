//
//  ViewController.m
//  Modal_Code
//
//  Created by  baohukeji-5 on 15/1/15.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "ModalTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


/*! 模态的几种方式
 typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
 UIModalPresentationFullScreen = 0,
 UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2),
 UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2),
 UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
 UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
 UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
 };
 */

/*
typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
    UIModalTransitionStyleCoverVertical = 0,
    UIModalTransitionStyleFlipHorizontal,
    UIModalTransitionStyleCrossDissolve,
    UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2),
};
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ModalTableViewController *modalVC = [[ModalTableViewController alloc] init];
    
    //modalVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    modalVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:modalVC animated:YES completion:nil];
}

@end
