//
//  SyncAndAsyncFuncVC.m
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/9.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#import "SyncAndAsyncFuncVC.h"

@interface SyncAndAsyncFuncVC ()

@end

@implementation SyncAndAsyncFuncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//----------------通过sb加载----------------
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.title = @"Sync&Async";
    }
    return self;
}

//----------------通过xib加载---------------
/*
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}
 */

//主队列同步 (容易引起死锁)
- (IBAction)mainQueueSyncFunc:(UIButton *)sender {
    NSLog(@"11111");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"22222");
    });
    NSLog(@"33333");
}
//同步串行  1 2 3
- (IBAction)syncSerial:(UIButton *)sender {
    const char * queueName = [@"syncSerial" UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
    NSLog(@"111111--%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"222222--%@",[NSThread currentThread]);
    });
    NSLog(@"333333--%@",[NSThread currentThread]);
}
//主队列异步
- (IBAction)mainQueueAsync:(UIButton *)sender {
    NSLog(@"1--%@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2--%@",[NSThread currentThread]);
        NSLog(@"3--%@",[NSThread currentThread]);
        NSLog(@"4--%@",[NSThread currentThread]);
        NSLog(@"5--%@",[NSThread currentThread]);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.1), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"6--%@",[NSThread currentThread]);
    });
    NSLog(@"7--%@",[NSThread currentThread]);
}
//异步串行  1 2 6  或 1 6 2等
- (IBAction)asyncSerial:(UIButton *)sender {
    const char * queueName = [@"asyncSerial" UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
    NSLog(@"111111--%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"222222--%@",[NSThread currentThread]);
        NSLog(@"333333--%@",[NSThread currentThread]);
        NSLog(@"444444--%@",[NSThread currentThread]);
        NSLog(@"555555--%@",[NSThread currentThread]);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"666666--%@",[NSThread currentThread]);
    });
}
//全局队列同步  1 2 3 4 5 6
- (IBAction)globalQueueSync:(id)sender {
    NSLog(@"111111--%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"222222--%@",[NSThread currentThread]);
        NSLog(@"333333--%@",[NSThread currentThread]);
        NSLog(@"444444--%@",[NSThread currentThread]);
        NSLog(@"555555--%@",[NSThread currentThread]);
    });
    NSLog(@"666666--%@",[NSThread currentThread]);
}
//同步并发
- (IBAction)syncConcurrent:(UIButton *)sender {
    const char * queueName = [@"syncConcurrent" UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1--%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"2--%@",[NSThread currentThread]);
        NSLog(@"3--%@",[NSThread currentThread]);
        NSLog(@"4--%@",[NSThread currentThread]);
        NSLog(@"5--%@",[NSThread currentThread]);
    });
    NSLog(@"6--%@",[NSThread currentThread]);
}
//全局队列异步
- (IBAction)globalQueueAsync:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"1--%@",[NSThread currentThread]);
    }); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2--%@",[NSThread currentThread]);
        NSLog(@"3--%@",[NSThread currentThread]);
        NSLog(@"4--%@",[NSThread currentThread]);
        NSLog(@"5--%@",[NSThread currentThread]);
    });
    NSLog(@"6--%@",[NSThread currentThread]);
}
//异步并发
- (IBAction)asyncConcurrent:(UIButton *)sender {
    const char * queueName = [@"CONCURRENT" UTF8String];
    dispatch_queue_t queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1--%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        [[NSThread currentThread] setName:@"double"];
        //这里并没有引起死锁 (可查看控制台打印, 线程调用)
        NSLog(@"2--%@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3--%@",[NSThread currentThread]);
        });
        NSLog(@"4--%@",[NSThread currentThread]);
    });
    NSLog(@"5--%@",[NSThread currentThread]);
}

@end
