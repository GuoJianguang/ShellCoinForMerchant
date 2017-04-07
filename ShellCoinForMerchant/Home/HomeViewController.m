//
//  HomeViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "BillConsumptionTableViewCell.h"
#import "StateMentsMViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hidden = YES;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillConsumptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillConsumptionTableViewCell indentify]];
    if (!cell) {
        cell = [BillConsumptionTableViewCell newCell];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(190/750.);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 结算单管理
- (IBAction)jiesuandanBtn:(UIButton *)sender {
    StateMentsMViewController *stateMVC = [[StateMentsMViewController alloc]init];
    [self.navigationController pushViewController:stateMVC animated:YES];
}

#pragma mark - 订单管理
- (IBAction)orderManangeBtn:(UIButton *)sender {
    
    
}
@end
