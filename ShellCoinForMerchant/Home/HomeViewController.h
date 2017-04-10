//
//  HomeViewController.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)jiesuandanBtn:(UIButton *)sender;

- (IBAction)orderManangeBtn:(UIButton *)sender;

- (IBAction)orderEnter:(UIButton *)sender;



@end
