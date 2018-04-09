//
//  SyncAndAsyncFuncVC.m
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/9.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#import "SyncAndAsyncFuncVC.h"

@interface SyncAndAsyncFuncVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation SyncAndAsyncFuncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.textColor = [UIColor whiteColor];
}
//----------------通过sb加载----------------
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
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
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_SERIAL);
    NSLog(@"111111--%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"222222--%@",[NSThread currentThread]);
    });
    NSLog(@"333333--%@",[NSThread currentThread]);
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
//异步串行  1 2 6  或 1 6 2等
- (IBAction)asyncSerial:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_SERIAL);
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
//主队列异步
- (IBAction)mainQueueAsync:(UIButton *)sender {
    
}
//同步并发
- (IBAction)syncConcurrent:(UIButton *)sender {
}
//全局队列异步
- (IBAction)globalQueueAsync:(UIButton *)sender {
}
//异步并发
- (IBAction)asyncConcurrent:(UIButton *)sender {
}

@end
