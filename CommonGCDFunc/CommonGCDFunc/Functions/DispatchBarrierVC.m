//
//  DispatchBarrierVC.m
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/10.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#import "DispatchBarrierVC.h"

@interface DispatchBarrierVC ()

@end

@implementation DispatchBarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"DispatchBarrier";
    }
    return self;
}

- (IBAction)dispatchBarrierFunction1:(UIButton *)sender {
    //使用global_queue队列不能实现拦截功能
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4------%@",[NSThread currentThread]);
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"====拦截======%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"6------%@\n\n",[NSThread currentThread]);
    });
}
- (IBAction)dispatchBarrierFunction2:(UIButton *)sender {
    
}
- (IBAction)dispatchBarrierFunction3:(UIButton *)sender {
    
}
- (IBAction)dispatchBarrierFunction4:(UIButton *)sender {
    
}

@end
