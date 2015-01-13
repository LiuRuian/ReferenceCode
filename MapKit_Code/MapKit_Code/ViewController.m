//
//  ViewController.m
//  MapKit_Code
//
//  Created by  baohukeji-5 on 15/1/8.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (nonatomic, strong)MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
- (IBAction)myBtnAction:(UIButton *)sender;

@end

/**
 CLLocation : 封装位置信息（经纬度、海拔）
 CLPlacemark : 封装地标信息（位置信息CLLocation、地名name、国家country）
 MKUserLocation : 封装地图上大头针的位置信息（位置信息CLLocation、标题title、子标题subtitle）
 CLLocationDegrees : 度数（经度、纬度）
 CLLocationCoordinate2D : 地理坐标（经度CLLocationDegrees longitude、纬度CLLocationDegrees latitude）
 MKCoordinateSpan : 跨度（经度跨度CLLocationDegrees longitudeDelta、纬度跨度CLLocationDegrees latitudeDelta）
 MKCoordinateRegion: 区域（中心位置CLLocationCoordinate2D center、区域跨度MKCoordinateSpan span）
 */



/* mapType
 MKMapTypeStandard = 0,  // 标准地图
 MKMapTypeSatellite,     // 卫星地图
 MKMapTypeHybrid         // 普通地图覆盖于卫星云图之上
 */

/* userTrackingMode
 
    MKUserTrackingModeNone = 0, // 不跟踪位置
	MKUserTrackingModeFollow,   //  跟踪用户位置
	MKUserTrackingModeFollowWithHeading,   // 跟踪用户位置带着方向
 
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 初始化地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView = mapView;
    // 2. 设置地图的类型
    mapView.mapType = MKMapTypeStandard;
    
    // 3. 设置用户的跟踪模式
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 4. 设置用户的代理
    mapView.delegate = self;
    
    
//    // 5. 设置开始地图的中心位置
//    CLLocationDegrees latitude = 40;    // 设置纬度
//    CLLocationDegrees longitude = 116;  // 设置经度
//    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);                     // 设置中心点
//    [mapView setCenterCoordinate:coordinate animated:YES];
//    
//    
//    //  6.设置地图显示的区域
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);  // 设置跨度
//    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);  // 设置区域(位置中心点,和跨度范围)
//    [mapView setRegion:region animated:YES];
    
    
    [self.view addSubview:mapView];
    
    
}

#pragma mark -实现代理方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    userLocation.title = @"我的位置";
    userLocation.subtitle = @"北京";
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES ];
}


// 地图区域改变了就会调用,缩放和移动位置调用,显示位置和显示范围改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D center = mapView.region.center;   // 获得区域中心
    MKCoordinateSpan pan = mapView.region.span;              // 获得区域的跨度
    
    NSLog(@"latitude =%f, longitude = %f \n latitudeDelta = %f,longitudeDelta = %f ", center.latitude,center.longitude,pan.latitudeDelta,pan.longitudeDelta);
    
    NSLog(@"regionWillChangeAnimated");
}

// 设置显示区域

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"regionDidChangeAnimated");
    
    CLLocationCoordinate2D center = mapView.userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion regin = MKCoordinateRegionMake(center, span);
    
    [self.mapView setRegion:regin animated:YES];
}

// 回到用户的当前位置
- (IBAction)myBtnAction:(UIButton *)sender {
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}
@end
