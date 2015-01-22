//
//  ViewController.m
//  UIBlurEffect_Code
//
//  Created by  baohukeji-5 on 15/1/19.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
@interface ViewController ()
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"bg"];
    
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    UIImage *newImage = [image applyBlurWithRadius:8 tintColor:tintColor saturationDeltaFactor:2.2 maskImage:nil] ;
    

    
    self.blurImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.blurImageView.image = newImage;
    
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    self.visualEffectView = visualEffectView;
//    visualEffectView.alpha = 0.7;
//    visualEffectView.frame = self.blurImageView.bounds;
//    
//    [self.blurImageView addSubview:visualEffectView];
    [self.view addSubview:self.blurImageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
