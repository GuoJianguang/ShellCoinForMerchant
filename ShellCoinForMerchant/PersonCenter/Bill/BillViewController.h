//
//  BillViewController.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,BillType){
    BillType_income = 1,//收入
    BillType_spending = 2,//支出
};
@interface BillViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (nonatomic, assign)BillType billtype;

@end
