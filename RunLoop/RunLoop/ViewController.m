//
//  ViewController.m
//  run
//
//  Created by  baohukeji-5 on 15/1/13.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"
#import <CoreFoundation/CoreFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSThread detachNewThreadSelector:@selector(observerRunLoop) toTarget:self withObject:nil];
    
}



- (void)observerRunLoop{
    //建立自动释放池
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //获得当前thread的Run loop
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    
    //设置Run loop observer的运行环境
    CFRunLoopObserverContext context = {0, self, NULL, NULL, NULL};
    
    //创建Run loop observer对象
    //第一个参数用于分配observer对象的内存
    //第二个参数用以设置observer所要关注的事件，详见回调函数myRunLoopObserver中注释
    //第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
    //第四个参数用于设置该observer的优先级
    //第五个参数用于设置该observer的回调函数
    //第六个参数用于设置该observer的运行环境
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    
    if (observer) {
        //将Cocoa的NSRunLoop类型转换成Core Foundation的CFRunLoopRef类型
        CFRunLoopRef cfRunLoop = [myRunLoop getCFRunLoop];
        //将新建的observer加入到当前thread的run loop
        CFRunLoopAddObserver(cfRunLoop, observer, kCFRunLoopDefaultMode);
    }
    
    //Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    
    NSInteger loopCount = 10;
    
    do {
        //启动当前thread的loop直到所指定的时间到达，在loop运行时，run loop会处理所有来自与该run loop联系的input source的数据
        //对于本例与当前run loop联系的input source只有一个Timer类型的source。
        //该Timer每隔0.1秒发送触发事件给run loop，run loop检测到该事件时会调用相应的处理方法。
        
        //由于在run loop添加了observer且设置observer对所有的run loop行为都感兴趣。
        //当调用runUnitDate方法时，observer检测到run loop启动并进入循环，observer会调用其回调函数，第二个参数所传递的行为是kCFRunLoopEntry。
        //observer检测到run loop的其它行为并调用回调函数的操作与上面的描述相类似。
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        //当run loop的运行时间到达时，会退出当前的run loop。observer同样会检测到run loop的退出行为并调用其回调函数，第二个参数所传递的行为是kCFRunLoopExit。
        
        loopCount--;
    } while (loopCount);
    
    //释放自动释放池
    [pool release];
    
}

void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
            //The entrance of the run loop, before entering the event processing loop.
            //This activity occurs once for each call to CFRunLoopRun and CFRunLoopRunInMode
        case kCFRunLoopEntry:
            NSLog(@"run loop entry");
            break;
            //Inside the event processing loop before any timers are processed
        case kCFRunLoopBeforeTimers:
            NSLog(@"run loop before timers");
            break;
            //Inside the event processing loop before any sources are processed
        case kCFRunLoopBeforeSources:
            NSLog(@"run loop before sources");
            break;
            //Inside the event processing loop before the run loop sleeps, waiting for a source or timer to fire.
            //This activity does not occur if CFRunLoopRunInMode is called with a timeout of 0 seconds.
            //It also does not occur in a particular iteration of the event processing loop if a version 0 source fires
        case kCFRunLoopBeforeWaiting:
            NSLog(@"run loop before waiting");
            break;
            //Inside the event processing loop after the run loop wakes up, but before processing the event that woke it up.
            //This activity occurs only if the run loop did in fact go to sleep during the current loop
        case kCFRunLoopAfterWaiting:
            NSLog(@"run loop after waiting");
            break;
            //The exit of the run loop, after exiting the event processing loop.
            //This activity occurs once for each call to CFRunLoopRun and CFRunLoopRunInMode
        case kCFRunLoopExit:
            NSLog(@"run loop exit");
            break;
            /*
             A combination of all the preceding stages
             case kCFRunLoopAllActivities:
             break;
             */
        default:
            break;
    }
}


- (void)doFireTimer:(NSString*)str
{
    NSLog(@"fire");
}

//- (void)threadMain
//{
//    // The application uses garbage collection, so no autorelease pool is needed.
//    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
//
//    // Create a run loop observer and attach it to the run loop.
//    CFRunLoopObserverContext  context = {0, self, NULL, NULL, NULL};
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                                               kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
//
//    if (observer)
//    {
//        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
//        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
//    }
//
//    // Create and schedule the timer.
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
//                                   selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
//
//    NSInteger loopCount = 10;
//    do
//    {
//        // Run the run loop 10 times to let the timer fire.
//        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//        loopCount--;
//    }
//    while (loopCount);
//}

- (void)skeletonThreadMain
{
    // Set up an autorelease pool here if not using garbage collection.
    BOOL done = NO;
    
    // Add your sources or timers to the run loop and do any other setup.
    
    do
    {
        // Start the run loop but return after each source is handled.
        SInt32    result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
        
        // If a source explicitly stopped the run loop, or if there are no
        // sources or timers, go ahead and exit.
        if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished))
            done = YES;
        
        // Check for any other exit conditions here and set the
        // done variable as needed.
    }
    while (!done);
    
    // Clean up code here. Be sure to release any allocated autorelease pools.
}



@end
