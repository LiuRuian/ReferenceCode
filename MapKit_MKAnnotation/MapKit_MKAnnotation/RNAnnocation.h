//
//  RNAnnocation.h
//  MapKit_MKAnnotation
//
//  Created by  baohukeji-5 on 15/1/10.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RNAnnocation : NSObject<MKAnnotation>
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic) CLLocation *location;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *imageName;
@end
