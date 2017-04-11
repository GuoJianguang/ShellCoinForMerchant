//
//  OrderManamentViewController.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "Bill1View.h"
#import "Bill12View.h"
@interface OrderManamentViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (nonatomic, strong)Bill1View *waitSureOrderView;
@property (nonatomic, strong)Bill12View *yetSureOrderView;
- (void)sureOrder:(NSString *)orerId;

@end
