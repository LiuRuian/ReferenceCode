//
//  RNAnnotation.h
//  MapKit_Code_地图路线
//
//  Created by  baohukeji-5 on 15/1/11.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RNAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
// Title and subtitle for use by selection UI.
@property (nonatomic,  copy) NSString *title;
@property (nonatomic,  copy) NSString *subtitle;

@end
