//
//  ViewController.m
//  NSOperation
//
//  Created by  baohukeji-5 on 15/1/2.
//  Copyright (c) 2015年 ruian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/*
 1. NSOperation的作用
 配合使用NSOperation和NSOperationQueue也能实现多线程编程
 
 2. NSOperation和NSOperationQueue实现多线程的具体步骤
 先将需要执行的操作封装到一个NSOperation对象中
 然后将NSOperation对象添加到NSOperationQueue中
 系统会自动将NSOperationQueue中的NSOperation取出来
 将取出的NSOperation封装的操作放到一条新线程中执行
 
 3. NSOperation是个抽象类，并不具备封装操作的能力，必须使用它的子类
 使用NSOperation子类的方式有3种
 NSInvocationOperation
 NSBlockOperation
 自定义子类继承NSOperation，实现内部相应的方法
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self operationQueueTest];
}


#pragma mark - NSOperationQueue

- (void)operationQueueTest
{
    // 1. 创建任务
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationTest) object:nil];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationTest) object:nil];
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationTest) object:nil];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationTest];
    }];
    
    // 2. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 3. 将任务加入队列
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    
    // 4. 设置最大并发数
    queue.maxConcurrentOperationCount = 2;
    
    // 5. 取消所有线程
    [queue cancelAllOperations];
    
    // 6.取消任务
    [operation1 cancel];
    
    // 7.暂停和恢复队列  - (BOOL)isSuspended;  // 判断队列是否暂停
    [queue setSuspended:NO];// YES代表暂停队列，NO代表恢复队列

    // 8.设置队列的优先级
    
    operation1.queuePriority = NSOperationQueuePriorityLow;
    /*
     设置NSOperation在queue中的优先级，可以改变操作的执行优先级
     - (NSOperationQueuePriority)queuePriority;
     - (void)setQueuePriority:(NSOperationQueuePriority)p;
     
     优先级的取值
     NSOperationQueuePriorityVeryLow = -8L,
     NSOperationQueuePriorityLow = -4L,
     NSOperationQueuePriorityNormal = 0,
     NSOperationQueuePriorityHigh = 4,
     NSOperationQueuePriorityVeryHigh = 8
     */
    
    // 9. 队列间的相互依赖
    [operation2 addDependency:operation1];
    
    /*NSOperation之间可以设置依赖来保证执行顺序
     比如一定要让操作A执行完后，才能执行操作B，可以这么写
     [operationB addDependency:operationA]; // 操作B依赖于操作A
     
     可以在不同queue的NSOperation之间创建依赖关系
*/
    // 10. 监听任务的完成
    // 任务完成后,回掉方法
    [operation3 setCompletionBlock:^{
        NSLog(@"operation3-%@",[NSThread currentThread]);
    }];
    
    operation4.completionBlock = ^{
        NSLog(@"operation4-%@",[NSThread currentThread]);
    };
    /*
     NSOperationQueue的作用
     NSOperation可以调用start方法来执行任务，但默认是同步执行的
     如果将NSOperation添加到NSOperationQueue（操作队列）中，系统会自动异步执行NSOperation中的操作
     
     添加操作到NSOperationQueue中
     - (void)addOperation:(NSOperation *)op;
     - (void)addOperationWithBlock:(void (^)(void))block;
     */
}


#pragma mark - NSBlockOperation

- (void)blockOperationTest
{
    // 1. 创建blockOperation任务
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self operationTest];
    }];
    
    NSBlockOperation *blockOperation2 = [[NSBlockOperation alloc] init];
    
    [blockOperation2 addExecutionBlock:^{
        [self operationTest];
    }];
    
    // 2.加入新的任务
    [blockOperation addExecutionBlock:^{
        [self operationTest];
    }];
    
    [blockOperation addExecutionBlock:^{
        [self operationTest];
    }];
    [blockOperation addExecutionBlock:^{
        [self operationTest];
    }];
    
    [blockOperation start];
    [blockOperation2 start];
    
    /* addExecutionBlock 此方法当任务大于1个时候,会自动开启线程.
     创建NSBlockOperation对象
     + (id)blockOperationWithBlock:(void (^)(void))block;
     
     通过addExecutionBlock:方法添加更多的操作
     - (void)addExecutionBlock:(void (^)(void))block;
     
     注意：只要NSBlockOperation封装的操作数 > 1，就会异步执行操作

     */
}

#pragma mark - NSInvocationOperation

- (void)invocationOperationTest{
    
    // 1. 创建NSInvocationOperation 任务
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationTest) object:nil];
    
    // 2. 开始任务
    [operation start];
    
    /*
     注意
     默认情况下，调用了start方法后并不会开一条新线程去执行操作，而是在当前线程同步执行操作
     只有将NSOperation放到一个NSOperationQueue中，才会异步执行操作
     */
}

- (void)operationTest
{
    NSLog(@"%@",[NSThread currentThread]);
}

@end
