//
//  RNQRCodeViewController.m
//  ZBar_Demo
//
//  Created by  baohukeji-5 on 15/1/24.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "RNQRCodeViewController.h"
#import "ZBarSDK.h"

#define kScanViewEdgeTop 40
#define kScanViewEdgeLeft 50

#define kTintColorAlpha 0.2
#define kDarkColorAlpha 0.5

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RNQRCodeViewController ()<ZBarReaderViewDelegate,UIAlertViewDelegate>

{
    UIView *_QrCodeLine;
    NSTimer *_timer;
    
    // 设置扫描动画
    UIView *_scanView;
    ZBarReaderView *_readerView;
   
}
@property (nonatomic,copy)NSString * symbolStr;
@end

@implementation RNQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描二维码";
    
    [self setScanView];
    _readerView= [[ZBarReaderView alloc]init];
    _readerView.frame =CGRectMake(0,64, kScreenW, kScreenH -64);
    _readerView.tracksSymbols=YES;
    _readerView.readerDelegate =self;
    [_readerView addSubview:_scanView];
    
    //关闭闪光灯
    _readerView.torchMode =0;

    [self.view addSubview:_readerView];

    //扫描区域
    [_readerView start];
    [self createTimer];
}


#pragma mark -- ZBarReaderViewDelegate

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image

{

    const zbar_symbol_t *symbol =zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString *symbolStr = [NSString stringWithUTF8String:zbar_symbol_get_data(symbol)];
   
    self.symbolStr = symbolStr;
     NSLog(@"symbolStr1 = %@",symbolStr);
    
    //判断是否包含 头'http:'
    NSString *regex =@"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:symbolStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往",nil];
    
    [alertView show];
    
    NSLog(@"symbolStr2 = %@",symbolStr);
    
    //判断是否包含 头'ssid:'
    NSString *ssid =@"ssid+:[^\\s]*";;
    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    
    if ([predicate evaluateWithObject:symbolStr]) {
    }
    
    else if([ssidPre evaluateWithObject:symbolStr]){
        
        NSArray *arr = [symbolStr componentsSeparatedByString:@";"];
        NSArray * arrInfoHead = [[arr objectAtIndex:0]componentsSeparatedByString:@":"];
        NSArray * arrInfoFoot = [[arr objectAtIndex:1]componentsSeparatedByString:@":"];
        symbolStr = [NSString stringWithFormat:@"ssid: %@ \n password:%@",
                     
                     [arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
        
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        
        //然后，可以使用如下代码来把一个字符串放置到剪贴板上：
        pasteboard.string = [arrInfoFoot objectAtIndex:1];
        
    }
    
}

- (void)setScanView
{
    _scanView=[[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenW, kScreenH-64)];
    
    _scanView.backgroundColor=[UIColor clearColor];
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenW,kScanViewEdgeTop)];
    
    upView.alpha = kTintColorAlpha;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [_scanView addSubview:upView];

    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,kScanViewEdgeTop,kScanViewEdgeLeft,kScreenW-2*kScanViewEdgeLeft)];
    
    leftView.alpha =kTintColorAlpha;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [_scanView addSubview:leftView];
    
    
    
    /******************中间扫描区域****************************/
    
    UIImageView *scanCropView=[[UIImageView alloc] initWithFrame:CGRectMake(kScanViewEdgeLeft,kScanViewEdgeTop, kScreenW-2*kScanViewEdgeLeft,kScreenW-2*kScanViewEdgeLeft)];
    

    scanCropView.layer.borderColor=[UIColor greenColor].CGColor;
    scanCropView.layer.borderWidth=2.0;

    scanCropView.backgroundColor=[UIColor clearColor];
    
    [_scanView addSubview:scanCropView];

    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW-kScanViewEdgeTop,kScanViewEdgeTop, kScanViewEdgeLeft,kScreenW-2*kScanViewEdgeLeft)];
    
    rightView.alpha =kTintColorAlpha;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [_scanView addSubview:rightView];
    

    //底部view
    
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenW-2*kScanViewEdgeLeft+kScanViewEdgeTop,kScreenW, kScreenH-(kScreenW-2*kScanViewEdgeLeft+kScanViewEdgeTop)-64)];
    
    //downView.alpha = TINTCOLOR_ALPHA;
    
    downView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kTintColorAlpha];
    
    [_scanView addSubview:downView];
    
    
    
    //用于说明的label
    
    UILabel *labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(0,5, kScreenW,20);
    labIntroudction.numberOfLines=1;
    labIntroudction.font=[UIFont systemFontOfSize:15.0];
    labIntroudction.textAlignment=NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码对准方框，即可自动扫描";
    [downView addSubview:labIntroudction];
    
    
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, downView.frame.size.height-100.0,kScreenW, 100.0)];
    
    darkView.backgroundColor = [[UIColor blackColor]  colorWithAlphaComponent:kDarkColorAlpha];
    
    [downView addSubview:darkView];
    
    
    
    //用于开关灯操作的button
    
    UIButton *openButton=[[UIButton alloc] initWithFrame:CGRectMake(10,20, 300.0, 40.0)];
    
    [openButton setTitle:@"开启闪光灯" forState:UIControlStateNormal];
    
    [openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    openButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    openButton.backgroundColor=[UIColor greenColor];
    
    openButton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    
    [openButton addTarget:self action:@selector(openLight)forControlEvents:UIControlEventTouchUpInside];
    
    [darkView addSubview:openButton];
    
    
    
    //画中间的基准线
    
    _QrCodeLine = [[UIView alloc] initWithFrame:CGRectMake(kScanViewEdgeLeft,kScanViewEdgeTop, kScreenW-2*kScanViewEdgeLeft,2)];
    
    _QrCodeLine.backgroundColor = [UIColor greenColor];
    
    [_scanView addSubview:_QrCodeLine];
}


- (void)openLight
{
    
    if (_readerView.torchMode ==0) {
        
        _readerView.torchMode =1;
        
    }else
        
    {
        _readerView.torchMode =0;
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    if (_readerView.torchMode ==1) {
        
        _readerView.torchMode =0;
        
    }
    [self stopTimer];
    [_readerView stop];
}

- (void)createTimer
{
    //创建一个时间计数
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
    
}

- (void)stopTimer
{
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer =nil;
    }
}

//二维码的横线移动

- (void)moveUpAndDownLine

{
    
    CGFloat Y=_QrCodeLine.frame.origin.y;
    
    //CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, VIEW_WIDTH-2*SCANVIEW_EdgeLeft, 1)]
    
    if (kScreenW-2*kScanViewEdgeLeft+kScanViewEdgeTop==Y){
        
        
        
        [UIView beginAnimations:@"asa" context:nil];
        
        [UIView setAnimationDuration:1];
        
        _QrCodeLine.frame=CGRectMake(kScanViewEdgeLeft, kScanViewEdgeTop, kScreenW-2*kScanViewEdgeLeft,1);
        
        [UIView commitAnimations];
        
    }else if(kScanViewEdgeTop==Y){
        
        [UIView beginAnimations:@"asa" context:nil];
        
        [UIView setAnimationDuration:1];
        
        _QrCodeLine.frame=CGRectMake(kScanViewEdgeLeft, kScreenW-2*kScanViewEdgeLeft+kScanViewEdgeTop, kScreenW-2*kScanViewEdgeLeft,1);
        
        [UIView commitAnimations];
        
    }

}

// 跳转页面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.symbolStr]];
    }
}

@end
