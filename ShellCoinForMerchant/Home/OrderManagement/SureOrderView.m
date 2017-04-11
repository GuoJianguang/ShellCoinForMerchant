//
//  SettlementPayWayView.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureOrderView.h"
#import "OrderManamentViewController.h"

@implementation SureOrderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureOrderView" owner:nil options:nil][0];
        self.titleLabel.textColor = MacoTitleColor;
        [self.cancelBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        self.itemView.layer.cornerRadius = 8;
        self.itemView.layer.masksToBounds = YES;
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self sendSubviewToBack:self.blackBackgoundView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.backgroundColor = [UIColor clearColor];
        self.blackBackgoundView.userInteractionEnabled = YES;
        [self.blackBackgoundView addGestureRecognizer:tap];
        
    }
    return  self;
}
- (void)tap{
//    [self removeFromSuperview];
}

#pragma mark - 确认支付和取消按钮
//确认
- (IBAction)sureBtn:(UIButton *)sender {
    
    NSDictionary *parms = @{@"orderId":self.orderId,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/order/confirm" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([self.deleagete respondsToSelector:@selector(sureSuccess)]) {
                [self.deleagete sureSuccess];
            }
            [self removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"确认失败，请稍后重试" duration:2.];
    }];
}
//取消
- (IBAction)cancelBtn:(UIButton *)sender {
    [self removeFromSuperview];

}
- (IBAction)closeBtn:(UIButton *)sender {
    [self removeFromSuperview];

}
@end
