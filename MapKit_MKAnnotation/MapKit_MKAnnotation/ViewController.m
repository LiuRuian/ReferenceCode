//
//  ViewController.m
//  MapKit_MKAnnotation
//
//  Created by  baohukeji-5 on 15/1/10.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "RNAnnocation.h"
#import "RNAnnotationView.h"
@interface ViewController () <MKMapViewDelegate> // 添加代理
- (IBAction)addAnnocation:(UIButton *)sender;
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView = mapView;
    mapView.delegate = self;    // 设置代理
    mapView.userTrackingMode = MKUserTrackingModeFollow ;
    [self.view addSubview:mapView];
}

// 添加自定义大头针 方法1
// 自定义MKAnnotationView,mapView的代理方法
// MKPinAnnotationView 的父类是 UIView

/*
 #import <MapKit/MKFoundation.h>
 #import <MapKit/MKAnnotationView.h>
 
 typedef NS_ENUM(NSUInteger, MKPinAnnotationColor) {
 MKPinAnnotationColorRed = 0,
 MKPinAnnotationColorGreen,
 MKPinAnnotationColorPurple
 } NS_ENUM_AVAILABLE(10_9, 3_0);
 
 MK_CLASS_AVAILABLE(10_9, 3_0)
 @interface MKPinAnnotationView : MKAnnotationView
 @property (nonatomic) MKPinAnnotationColor pinColor;
 @property (nonatomic) BOOL animatesDrop;
 @end
 
 */

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    // 查看可以循环利用的大头针
//    static NSString *annotationStr = @"anno";
//    // MKPinAnnotationView 父类 MKAnnotationView
//    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationStr];
//
//    if(!pin)
//    {
//        pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:annotationStr];
//        // 设置大头针颜色
//        
//        pin.pinColor = MKPinAnnotationColorPurple;
//        // 设置大头针动画
//        pin.animatesDrop = YES;
//        
//        // 显示标题和子标题文字
//        pin.canShowCallout = YES;
//        
//        // 标题偏移量
//        pin.CalloutOffset = CGPointMake(0, -20);
//        
//        // 设置标题左右两边的图片
//        pin.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    }
//    pin.image = [UIImage imageNamed:@"annocation"];
//    pin.annotation = annotation;
//    return pin;
//}

//添加自定义大头方法2 封装
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(RNAnnocation *)annotation
{
    if (![annotation isKindOfClass:[RNAnnocation class]]) return nil;  //返回 nil 按系统默认的方式创建大头针
    // 查看可以循环利用的大头针
    // 封装AnnotationView
    RNAnnotationView *annotationView  = [RNAnnotationView annotationViewWithMapView:mapView];
   
    annotationView.annotation = annotation;
  
    return annotationView;
}


// 按钮触发添加大头针方法

- (IBAction)addAnnocation:(UIButton *)sender {
    
    // 1. 创建自定义大头针
    RNAnnocation *annocation = [[RNAnnocation alloc] init];
    
    // 2. 设置大头针的位置
    annocation.coordinate = CLLocationCoordinate2DMake(39, 116);
    
    // 3. 设置大头针的标题
    annocation.title = @"北京";
    
    // 4. 设置大头针的子标题
    annocation.subtitle = @"海淀";
    
    // 5. 设置图片的名称
    annocation.imageName = @"annocation";
    
    // 6.将大头针加入地图
    [self.mapView addAnnotation:annocation];
}


@end
