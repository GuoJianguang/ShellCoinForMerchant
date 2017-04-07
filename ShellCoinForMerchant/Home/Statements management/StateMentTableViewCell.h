//
//  StateMentTableViewCell.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateMentTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *time_label;

@property (weak, nonatomic) IBOutlet UILabel *status_label;

@property (weak, nonatomic) IBOutlet UIImageView *mark_imageView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalBishuLabel;
@property (weak, nonatomic) IBOutlet UILabel *titalBIshu;
@property (weak, nonatomic) IBOutlet UILabel *shouldJiesuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouldJiesuan;
@property (weak, nonatomic) IBOutlet UILabel *gouJiesuanLabel;

@end
