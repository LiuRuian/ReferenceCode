//------------------------------------------------------------------------
//  Copyright 2010 (c) Jeff Brown <spadix@users.sourceforge.net>
//
//  This file is part of the ZBar Bar Code Reader.
//
//  The ZBar Bar Code Reader is free software; you can redistribute it
//  and/or modify it under the terms of the GNU Lesser Public License as
//  published by the Free Software Foundation; either version 2.1 of
//  the License, or (at your option) any later version.
//
//  The ZBar Bar Code Reader is distributed in the hope that it will be
//  useful, but WITHOUT ANY WARRANTY; without even the implied warranty
//  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser Public License for more details.
//
//  You should have received a copy of the GNU Lesser Public License
//  along with the ZBar Bar Code Reader; if not, write to the Free
//  Software Foundation, Inc., 51 Franklin St, Fifth Floor,
//  Boston, MA  02110-1301  USA
//
//  http://sourceforge.net/projects/zbar
//------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import "ZBarImageScanner.h"

@class AVCaptureSession, AVCaptureDevice;
@class CALayer;
@class ZBarImageScanner, ZBarCaptureReader, ZBarReaderView;

// delegate is notified of decode results.
// 代理被通知扫描的结果
@protocol ZBarReaderViewDelegate < NSObject >  //协议

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image;

@end

// read barcodes from the displayed video preview.  the view maintains //从显示的视频预览读取条形码
// a complete video capture session feeding a ZBarCaptureReader and
// presents the associated preview with symbol tracking annotations.

@interface ZBarReaderView
    : UIView
{
    id<ZBarReaderViewDelegate> readerDelegate;
    ZBarCaptureReader *captureReader;
    CGRect scanCrop, effectiveCrop;
    CGAffineTransform previewTransform;
    CGFloat zoom, zoom0, maxZoom;
    UIColor *trackingColor;
    BOOL tracksSymbols, showsFPS;
    NSInteger torchMode;
    UIInterfaceOrientation interfaceOrientation;
    NSTimeInterval animationDuration;

    CALayer *preview, *overlay, *tracking, *cropLayer;
    UIView *fpsView;
    UILabel *fpsLabel;
    UIPinchGestureRecognizer *pinch;
    CGFloat imageScale;
    CGSize imageSize;
    BOOL started, running;
}

// supply a pre-configured image scanner. /*! 提供一个预先配置的扫描图像*/
- (id) initWithImageScanner: (ZBarImageScanner*) imageScanner;

// start the video stream and barcode reader. //启动视频流和条形码阅读器
- (void) start;

// stop the video stream and barcode reader.  //停止视频流和条形码阅读器
- (void) stop;

// clear the internal result cache.  //清空内存中缓存的结果
- (void) flushCache;

// compensate for device/camera/interface orientation  //  补偿 设备/相机/界面 方向
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration;

// delegate is notified of decode results.  // 代理
@property (nonatomic, assign) id<ZBarReaderViewDelegate> readerDelegate;

// access to image scanner for configuration.  // 获得图像扫描器配置
@property (nonatomic, readonly) ZBarImageScanner *scanner;

// whether to display the tracking annotation for uncertain barcodes
// (default YES).   // 是否显示跟踪注释对于不确定的条形码  默认是YES
@property (nonatomic) BOOL tracksSymbols;

// color of the tracking box (default green)   // 跟踪框的颜色,默认是绿色
@property (nonatomic, retain) UIColor *trackingColor;

// enable pinch gesture recognition for zooming the preview/decode
// (default YES).  // 能够用手势识别缩放预览/解码  默认是 YES
@property (nonatomic) BOOL allowsPinchZoom;

// torch mode to set automatically (default Auto).  // 闪光灯自动设置 默认为自动
@property (nonatomic) NSInteger torchMode;

// whether to display the frame rate for debug/configuration
// (default NO). // 是否显示帧率对于调试/配置 默认是NO
@property (nonatomic) BOOL showsFPS;

// zoom scale factor applied to video preview *and* scanCrop. //缩放比例因子应用于视频预览*和* 扫描范围。
// also updated by pinch-zoom gesture.  clipped to range [1,maxZoom], //通过缩放手势更新剪切的范围, 默认是1.25
// defaults to 1.25
@property (nonatomic) CGFloat zoom;
- (void) setZoom: (CGFloat) zoom
        animated: (BOOL) animated;

// maximum settable zoom factor.  // 最大的设置缩放因子
@property (nonatomic) CGFloat maxZoom;

// the region of the image that will be scanned.  normalized coordinates. // 将要被扫描的图片范围  (规范坐标)
@property (nonatomic) CGRect scanCrop;

// additional transform applied to video preview.// 额外的转换应用到视频预览
// (NB *not* applied to scan crop)
@property (nonatomic) CGAffineTransform previewTransform;

// specify an alternate capture device. // 指定一个替代捕获设备
@property (nonatomic, retain) AVCaptureDevice *device;

// direct access to the capture session.  warranty void if opened...// 直接访问捕获会话. 如果打开授权无效
@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) ZBarCaptureReader *captureReader;

// this flag still works, but its use is deprecated
@property (nonatomic) BOOL enableCache;

@end
