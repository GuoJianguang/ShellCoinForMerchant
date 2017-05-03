//
//  TradeInViewController.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface TradeInViewController : BaseViewController

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputMoneyViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *canWithDrawLabel;

@property (weak, nonatomic) IBOutlet UILabel *canWithDrawMoney;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

- (IBAction)tradinRecod:(id)sender;

@end
