//
//  MyQRCodeViewController.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MyQRCodeViewController : BaseViewController

- (IBAction)backBtn:(UIButton *)sender;

- (IBAction)goSureOrderBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *sureOrderBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *itemView;

@end
