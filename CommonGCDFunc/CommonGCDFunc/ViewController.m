//
//  ViewController.m
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/8.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#import "ViewController.h"
#import "SyncAndAsyncFuncVC.h"
#import "DispatchGroupVC.h"
#import "DispatchBarrierVC.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"常见的async和sync用法";
            break;
        case 1:
            cell.textLabel.text = @"调度组的使用";
            break;
        case 2:
            cell.textLabel.text = @"栅栏行数的使用";
            break;
        case 3:
            cell.textLabel.text = @"信号量的分析";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"SyncAndAsyncFuncVC" bundle:nil];
            SyncAndAsyncFuncVC * vc = [sb instantiateViewControllerWithIdentifier:@"SyncAndAsyncFuncVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            DispatchGroupVC * vc = [[DispatchGroupVC alloc] initWithNibName:@"DispatchGroupVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            DispatchBarrierVC * vc = [[DispatchBarrierVC alloc] initWithNibName:@"DispatchBarrierVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
