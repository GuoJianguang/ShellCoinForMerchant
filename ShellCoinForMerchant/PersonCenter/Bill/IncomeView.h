//
//  IncomeView.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)reload;
@end
