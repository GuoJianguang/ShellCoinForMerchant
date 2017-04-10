//
//  SettlementPayWayView.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SettlementPayWayView.h"

@implementation SettlementPayWayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SettlementPayWayView" owner:nil options:nil][0];
        self.titleLabel.textColor = MacoTitleColor;
        [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self sendSubviewToBack:self.blackBackgoundView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.backgroundColor = [UIColor clearColor];
        self.blackBackgoundView.userInteractionEnabled = YES;
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self setPayWay];
    }
    return  self;
}
- (void)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
#pragma mark - 设置支付规则
- (void)setPayWay{
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor = MacoTitleColor;
    self.wechatMarkBtn.hidden = YES;
    //默认余额支付
    self.payWay_type = Payway_type_banlance;
    double xiaofeiJin = [[ShellCoinUserInfo shareUserInfos].consumeBalance doubleValue];
    double payMoney = [self.money doubleValue];
    double yuE = [[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue];
    
    
    if (xiaofeiJin >= payMoney) {
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(购物券%.2f元)",payMoney];
//        self.xiaofeiJinMoney = xiaofeiJin - payMoney;
    }else if (payMoney > xiaofeiJin && payMoney - xiaofeiJin < yuE && xiaofeiJin !=0){
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(购物券%.2f元+余额%.2f元)",xiaofeiJin,(payMoney - xiaofeiJin)];
//        self.xiaofeiJinMoney = 0;
    }else if(xiaofeiJin==0 && payMoney < yuE){
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(余额%.2f元)",payMoney];
//        self.xiaofeiJinMoney = 0;
    }else if(payMoney > yuE + xiaofeiJin){
        self.yuELabel.text = [NSString stringWithFormat:@"余额和购物券不足，请用微信或者现金支付"];
        
        self.payWay_type = Payway_type_wechat;
        self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
        self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
        self.yuEMarkBtn.hidden = YES;
        self.wechatBtn.selected = YES;
        self.wechatLabel.textColor = MacoColor;
        self.yuELabel.textColor = MacoTitleColor;
        self.wechatMarkBtn.hidden = NO;
        self.yuEMarkBtn.enabled = self.yuEbtn.enabled = NO;
        return;
    }
    
    self.yuEMarkBtn.enabled = self.yuEbtn.enabled = YES;
}


- (IBAction)yuEBtn:(UIButton *)sender {
    self.payWay_type = Payway_type_banlance;
    self.wechatBtn.selected = NO;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_sel"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    self.wechatLabel.textColor  = MacoTitleColor;
    self.wechatMarkBtn.hidden  = YES;
}
- (IBAction)wechatBtn:(UIButton *)sender {
    
    self.payWay_type = Payway_type_wechat;
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.yuEMarkBtn.hidden= YES;
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.yuELabel.textColor =MacoTitleColor;
    self.wechatMarkBtn.hidden = NO;
}

#pragma mark - 确认支付和取消按钮

//确认
- (IBAction)sureBtn:(UIButton *)sender {
    
}
//取消
- (IBAction)cancelBtn:(UIButton *)sender {
        [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end
