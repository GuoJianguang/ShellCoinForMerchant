//
//  SettlementPayWayView.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SettlementPayWayView.h"
#import "StateMentTableViewCell.h"

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

- (void)setDataModel:(StateMentDataModel *)dataModel
{
    _dataModel = dataModel;
    [self setPayWay];
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
    double payMoney = [self.dataModel.totalAmount doubleValue];
    double yuE = [[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue];
    
    
    if (yuE >= payMoney) {
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付"];
//        self.xiaofeiJinMoney = xiaofeiJin - payMoney;
    }else{
        self.yuELabel.text = [NSString stringWithFormat:@"余额支付(余额不足)"];
        
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
    
    
    switch (self.payWay_type) {
        case Payway_type_wechat://微信支付
        {
            
            
        }
            break;
        case Payway_type_banlance://余额支付
        {
            NSDictionary *parms = @{@"settleId":self.dataModel.orderId,
                                  @"token":[ShellCoinUserInfo shareUserInfos].token};
            [HttpClient POST:@"pay/mch/settle/balancePay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                if (IsRequestTrue) {
                    if ([self.delegate respondsToSelector:@selector(settlementSuccess)]) {
                        [ShellCoinUserInfo shareUserInfos].aviableBalance = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue] -[self.dataModel.totalAmount doubleValue]];
                        [[JAlertViewHelper shareAlterHelper]showTint:@"结算成功" duration:2.];
                        [self.delegate settlementSuccess];
                        [self removeFromSuperview];
                    }
                }
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"结算失败，请稍后重试" duration:2.];
            }];
        }
            break;
            
        default:
            break;
    }
    
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
