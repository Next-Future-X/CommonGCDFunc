//
//  DispatchGroupVC.m
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/10.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#import "DispatchGroupVC.h"

@interface DispatchGroupVC ()
@property (weak, nonatomic) IBOutlet UIButton *function1Btn;
@property (weak, nonatomic) IBOutlet UIButton *function2Btn;
@property (weak, nonatomic) IBOutlet UIButton *function3Btn;
@end

@implementation DispatchGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.function1Btn.layer.cornerRadius = 5;
    self.function1Btn.clipsToBounds = YES;
    
    self.function2Btn.layer.cornerRadius = 5;
    self.function2Btn.clipsToBounds = YES;
    
    self.function3Btn.layer.cornerRadius = 5;
    self.function3Btn.clipsToBounds = YES;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"DispatchGroup";
    }
    return self;
}

//常规方式  notify
/*
 1.notify会等待调度组中所有回调都执行完成后, 才调用
 2.位于notify之后的输出, 并不会等待notify执行之后才调用
 */
- (IBAction)dispatchGroupFunction1:(UIButton *)sender {
    NSLog(@"1------%@",[NSThread currentThread]);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dfdf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"2------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"4------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"5------%@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"=====调度组完成=====");
    });
    NSLog(@"6------%@",[NSThread currentThread]);
}

//常规方式  wait
/*
 1.当调度组中所有任务完成后, 可以使用notify 或 wait来执行后续代码, 区别是notify为非阻塞, wait是阻塞的
 2.同样wait也可放在调度组任务中, 阻塞后续任务的执行
 */
- (IBAction)dispatchGroupFunction2:(UIButton *)sender {
    NSLog(@"1------%@",[NSThread currentThread]);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dfdf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"2------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"4------%@",[NSThread currentThread]);
    });
    //wait放在任务中
//    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
    dispatch_group_async(group, queue, ^{
        NSLog(@"5------%@",[NSThread currentThread]);
    });
    //wait放在所有任务后
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"=====调度组完成=====");
//    });
    NSLog(@"6------%@",[NSThread currentThread]);
}

//使用enter leave的方式
/*
 1.可实现前一方法的效果
 2.采用此种方式, 可实现同步方式, 按顺序执行任务(视业务选用)
 3.需要注意的是dispatch_group_enter(_) 和 dispatch_group_leave(_) 是成对出现的,有入组就有出组
 */
- (IBAction)dispatchGroupFunction3:(UIButton *)sender {
    NSLog(@"1------%@",[NSThread currentThread]);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"2------%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"3------%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"4------%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"5------%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"=====调度组完成=====%@",[NSThread currentThread]);
    });
    NSLog(@"6------%@",[NSThread currentThread]);
}

@end
