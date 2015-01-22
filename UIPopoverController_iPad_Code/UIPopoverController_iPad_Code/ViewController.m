//
//  ViewController.m
//  UIPopoverController_iPad_Code
//
//  Created by  baohukeji-5 on 15/1/15.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "PopTableViewController.h"
@interface ViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popover;


- (IBAction)btnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *swichAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*!
 setContentViewController:animated:。设定内容视图大小的方法。
 presentPopoverFromRect:inView:permittedArrowDirections:animated:。指定一个矩形区􏶆
 的位置作为􏶔点来􏲶现Popover视图的方法。
 􏵘 presentPopoverFromBarButtonItem:permittedArrowDirections:animated:。指定一个按钮作
 为􏶔点来􏲶现Popover视图的方法。
 􏵘 dismissPopoverAnimated:。关􏻬Popover视图的方法。
 􏵘 popoverVisible。判断Popover视图是否可见。
 􏵘 popoverArrowDirection。判断Popover视图􏷧􏷨的方􏵷。
 */
/* 箭头的方向
 
 typedef NS_OPTIONS(NSUInteger, UIPopoverArrowDirection) {
 UIPopoverArrowDirectionUp = 1UL << 0,
 UIPopoverArrowDirectionDown = 1UL << 1,
 UIPopoverArrowDirectionLeft = 1UL << 2,
 UIPopoverArrowDirectionRight = 1UL << 3,
 UIPopoverArrowDirectionAny = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight,
 UIPopoverArrowDirectionUnknown = NSUIntegerMax
 };
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    PopTableViewController *popVC = [[PopTableViewController alloc] init];
    
    // 1. 创建popViewController
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popVC];
    
    self.popover = popover;
    popover.delegate = self;
    // 2.设置尺寸
    popover.popoverContentSize = CGSizeMake(150, 400);
    
    // 3. 加载到导航栏上的位置
    [popover presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // 4. 过滤控件
    popover.passthroughViews = @[self.swichAction];

}

- (IBAction)btnAction:(UIButton *)sender {

    // 1. 创建popViewController
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:[[PopTableViewController alloc] init]];
    
    // 2. 设置popViewController 位置,加载到对应的view上
    [popover presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // 方法2 与上面的方法相同
//    [popover presentPopoverFromRect:sender.frame inView:sender.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - popoverDelegate 方法

//// 用户点击蒙版的时候pop是否可以dismiss,   NO是不dismiss
//- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
//{
//    return NO;
//}
//
///* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
// */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"dismiss");
}

/* -popoverController:willRepositionPopoverToRect:inView: is called on your delegate when the popover may require a different view or rectangle
 */
- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view
{
    NSLog(@"eeeee");
}

@end
