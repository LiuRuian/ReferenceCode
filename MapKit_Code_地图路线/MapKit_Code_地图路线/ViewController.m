//
//  ViewController.m
//  MapKit_Code_地图路线
//
//  Created by  baohukeji-5 on 15/1/11.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "RNAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    // 创建地理编码
    [self creatGeoCoder];
    
    [self.geoCoder geocodeAddressString:@"唐山" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *tsPM = [placemarks firstObject];
        // 1. 添加大头针
        RNAnnotation *annotation = [[RNAnnotation alloc] init];
        annotation.title = tsPM.locality;
        annotation.subtitle = tsPM.name;
        annotation.coordinate = tsPM.location.coordinate;
        [self.mapView addAnnotation:annotation];
        
        [self.geoCoder geocodeAddressString:@"北京" completionHandler:^(NSArray *placemarks, NSError *error) {
             CLPlacemark *bjPM = [placemarks firstObject];
            
            RNAnnotation *annotation = [[RNAnnotation alloc] init];
            annotation.title = bjPM.locality;
            annotation.subtitle = bjPM.name;
            annotation.coordinate = bjPM.location.coordinate;
            [self.mapView addAnnotation:annotation];
           
            [self drawLineWithSourceCLPM:tsPM DestinationCLPM:bjPM];
            
        }];
    }];
    
}

- (void)drawLineWithSourceCLPM:(CLPlacemark *)sourceCLPM DestinationCLPM:(CLPlacemark *)destinationCLPM
{
    if (sourceCLPM == nil || destinationCLPM == nil) {
        return;
    }
    // 2. 设置方向请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    // 3. 设置请求的起点
    // MKPlacemark 继承自 CLPlacemark
    // @interface MKPlacemark : CLPlacemark <MKAnnotation>
    MKPlacemark *sourcePM = [[MKPlacemark alloc] initWithPlacemark:sourceCLPM] ;
    request.source = [[MKMapItem alloc] initWithPlacemark:sourcePM];
    
    // 4. 设置请求的终点
    MKPlacemark *destinationPM = [[MKPlacemark alloc] initWithPlacemark:destinationCLPM];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPM];
    
    // 5. 根据请求创建方向
    MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
    
    // 6.执行请求
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            return ;
        }
        
        for (MKRoute *route in response.routes) {
            
            // 添加了遮盖,route路线的多段线polyline
            [self.mapView addOverlay:route.polyline];
        }
    }];
    
    // 遮盖 overlay
    
}


// 绘制遮盖调用代理方法
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    // 多线段的描述器
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    // 线段的宽度
    renderer.lineWidth = 3;
    // 线段的颜色
    renderer.strokeColor = [UIColor redColor];
    return  renderer;
}


// 创建地理编码方法
- (void)creatGeoCoder
{
    if (!_geoCoder) {
        
        self.geoCoder = [[CLGeocoder alloc] init];
    }
}

@end
