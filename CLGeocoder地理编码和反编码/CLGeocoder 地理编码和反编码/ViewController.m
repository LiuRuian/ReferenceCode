//
//  ViewController.m
//  CLGeocoder 地理编码和反编码
//
//  Created by  baohukeji-5 on 15/1/8.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController

/*
 
 CLPlacemark的字面意思是地标，封装详细的地址位置信息
 
 @property (nonatomic, readonly) CLLocation *location;
 地理位置
 
 @property (nonatomic, readonly) CLRegion *region;
 区域
 
 @property (nonatomic, readonly) NSDictionary *addressDictionary;
 详细的地址信息
 
 @property (nonatomic, readonly) NSString *name;
 地址名称
 
 @property (nonatomic, readonly) NSString *locality;
 城市
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //2. 解码地理位置
    [geocoder geocodeAddressString:@"三河" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *placemark  in placemarks) {
            
            NSLog(@"name = %@",placemark.name);     // name = Hebei Tangshan Fengrun Da Qituocun
            NSLog(@"addressDictionary = %@",placemark.addressDictionary);
            
            /*
             addressDictionary = {
             City = Tangshan;
             Country = China;
             CountryCode = CN;
             FormattedAddressLines =     (
             "Hebei Tangshan Fengrun Da Qituocun",
             "Da Qituocun",
             "Fengrun Tangshan",
             "Hebei China"
             );
             Name = "Hebei Tangshan Fengrun Da Qituocun";
             State = Hebei;
             SubLocality = Fengrun;
             }
             */
            
            NSLog(@"ISOcountryCode = %@",placemark.ISOcountryCode);  // ISOcountryCode = CN
            NSLog(@"postalCode = %@",placemark.postalCode);          // 邮编
            NSLog(@"administrativeArea  = %@",placemark.administrativeArea);  // administrativeArea  = Hebei
            NSLog(@"subAdministrativeArea  = %@",placemark.subAdministrativeArea );
            NSLog(@"locality = %@",placemark. locality   );    // locality = Tangshan
            NSLog(@"subLocality = %@",placemark.subLocality);  // subLocality = Fengrun
            NSLog(@"thoroughfare  = %@",placemark.thoroughfare );
            NSLog(@"subThoroughfare  = %@",placemark.subThoroughfare );
            NSLog(@"region = %@",placemark.region);
            // egion = CLCircularRegion (identifier:'<+39.60947000,-62.02152800> radius 11193838.25', center:<+39.60947000,-62.02152800>, radius:11193838.25m)

            NSLog(@" inlandWater = %@",placemark.inlandWater);
            NSLog(@" ocean = %@",placemark.ocean);         // 太平洋
            NSLog(@" areasOfInterest  = %d",placemark.areasOfInterest.count);
            NSLog(@" location = %@",placemark.location); // location = <+39.60947000,+117.97847200> +/- 100.00m (speed -1.00 mps / course -1.00) @ 1/8/15, 3:54:10 PM China Standard Time
        }
    }];
    
    
    // 3.反编码
    CLLocationDegrees latitude = 39.9;
    CLLocationDegrees longtitude = 118.15 ;
    
    // 4.设置地理位置
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *placemark  in placemarks) {
            
            NSLog(@"name = %@",placemark.name);     // name = Hebei Tangshan Fengrun Da Qituocun
            NSLog(@"addressDictionary = %@",placemark.addressDictionary);
            
            NSLog(@"ISOcountryCode = %@",placemark.ISOcountryCode);  // ISOcountryCode = CN
            NSLog(@"postalCode = %@",placemark.postalCode);          // 邮编
            NSLog(@"administrativeArea  = %@",placemark.administrativeArea);  // administrativeArea  = Hebei
            NSLog(@"subAdministrativeArea  = %@",placemark.subAdministrativeArea );
            NSLog(@"locality = %@",placemark. locality   );    // locality = Tangshan
            NSLog(@"subLocality = %@",placemark.subLocality);  // subLocality = Fengrun
            NSLog(@"thoroughfare  = %@",placemark.thoroughfare );
            NSLog(@"subThoroughfare  = %@",placemark.subThoroughfare );
            NSLog(@"region = %@",placemark.region);
            // egion = CLCircularRegion (identifier:'<+39.60947000,-62.02152800> radius 11193838.25', center:<+39.60947000,-62.02152800>, radius:11193838.25m)
            
            NSLog(@" inlandWater = %@",placemark.inlandWater);
            NSLog(@" ocean = %@",placemark.ocean);         // 太平洋
            NSLog(@" areasOfInterest  = %d",placemark.areasOfInterest.count);
            NSLog(@" location = %@",placemark.location); // location = <+39.60947000,+117.97847200> +/- 100.00m (speed -1.00 mps / course -1.00) @ 1/8/15, 3:54:10 PM China Standard Time
        }
    }];
    
}




@end
