//
//  PersonCenterTableViewCell.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *mybalance;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
- (IBAction)messageBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *balance;

@property (weak, nonatomic) IBOutlet UIButton *wirhDrawBtn;
- (IBAction)wirhDrawBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
- (IBAction)incomeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *spendingLabel;

- (IBAction)spendingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

- (IBAction)cleanBtn:(id)sender;
- (IBAction)aboutUSBtn:(id)sender;
- (IBAction)logoutBtn:(id)sender;

@end
