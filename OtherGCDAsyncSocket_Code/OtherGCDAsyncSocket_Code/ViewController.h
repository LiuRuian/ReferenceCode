//
//  ViewController.h
//  OtherGCDAsyncSocket_Code
//
//  Created by  baohukeji-5 on 15/1/5.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
@interface ViewController : UIViewController <GCDAsyncSocketDelegate>

- (IBAction)connetBtnAction:(UIButton *)sender;
- (IBAction)sendMessageBtnAction:(UIButton *)sender;

@end

