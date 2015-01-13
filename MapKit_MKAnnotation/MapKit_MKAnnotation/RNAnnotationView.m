//
//  RNAnnotationView.m
//  MapKit_MKAnnotation
//
//  Created by  baohukeji-5 on 15/1/10.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "RNAnnotationView.h"
#import "RNAnnocation.h"

@interface RNAnnotationView ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation RNAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView
{
    static NSString *annotationStr = @"anno";
    RNAnnotationView *annotationView = (RNAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationStr];
    
    if(!annotationView)
    {
        annotationView = [[RNAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:annotationStr];
    }

    return annotationView;
    
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super init]) {
        
        self.canShowCallout = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.leftCalloutAccessoryView = imageView;
        self.imageView = imageView;
    }
    return self;
}

- (void)setAnnotation:(RNAnnocation *)annotation
{
    [super setAnnotation:annotation];
    self.image = [UIImage imageNamed:annotation.imageName];
    self.imageView.image = self.image;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.imageView.frame, point)) {
        return self.imageView;
    }
    return [super hitTest:point withEvent:event];
}

@end
