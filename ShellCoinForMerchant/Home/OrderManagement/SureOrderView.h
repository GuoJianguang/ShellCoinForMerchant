//
//  SettlementPayWayView.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SureOrderView : UIView



@property (weak, nonatomic) IBOutlet UIView *blackBackgoundView;


@property (weak, nonatomic) IBOutlet UIView *itemView;





@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeBtn:(UIButton *)sender;


@end
