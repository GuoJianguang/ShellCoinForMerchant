//
//  SettlementPayWayView.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SettlementPayWayView.h"
#import "StateMentTableViewCell.h"
#import "WeXinPayObject.h"

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
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(310/375.));
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
    self.aliPayMarkBtn.hidden = YES;
    self.aliPayLabel.textColor  = MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];
    
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
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_sel"];
    self.yuEMarkBtn.hidden = NO;
    self.yuELabel.textColor = MacoColor;
    
    self.wechatLabel.textColor  = MacoTitleColor;
    self.wechatMarkBtn.hidden  = YES;
    self.wechatBtn.selected = NO;
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];

    self.aliPayLabel.textColor  = MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];
    
}

- (IBAction)wechatBtn:(UIButton *)sender {
    
    self.payWay_type = Payway_type_wechat;
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.wechatMarkBtn.hidden = NO;
    
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
    self.yuELabel.textColor =MacoTitleColor;
    self.yuEMarkBtn.hidden= YES;
    
    self.aliPayLabel.textColor  = MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];

}
- (IBAction)aliPay:(UIButton *)sender
{
    self.payWay_type = payway_type_alipay;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_sel"];
    self.aliPaytBtn.selected = YES;
    self.aliPayLabel.textColor = MacoColor;
    self.aliPayMarkBtn.hidden = NO;
    
    self.yuEImage.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
    self.yuELabel.textColor =MacoTitleColor;
    self.yuEMarkBtn.hidden= YES;
    
    self.wechatLabel.textColor  = MacoTitleColor;
    self.wechatMarkBtn.hidden  = YES;
    self.wechatBtn.selected = NO;
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
}
#pragma mark - 确认支付和取消按钮

//确认
- (IBAction)sureBtn:(UIButton *)sender {
    
    
    switch (self.payWay_type) {
        case Payway_type_wechat://微信支付
        {
            NSDictionary *parms = @{@"settleId":self.dataModel.orderId,
                                    @"token":[ShellCoinUserInfo shareUserInfos].token};
            [WeXinPayObject startWexinPay:parms];

//            [[JAlertViewHelper shareAlterHelper]showTint:@"微信支付未开通，请选择其他支付方式" duration:2.];
            
        }
            break;
        case Payway_type_banlance://余额支付
        {
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认用余额进行结算？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSDictionary *parms = @{@"settleId":self.dataModel.orderId,
                                        @"token":[ShellCoinUserInfo shareUserInfos].token};
                [SVProgressHUD showWithStatus:@"正在发送结算请求" maskType:SVProgressHUDMaskTypeBlack];
                [HttpClient POST:@"pay/mch/settle/balancePay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                    [SVProgressHUD dismiss];
                    if (IsRequestTrue) {
                        if ([self.delegate respondsToSelector:@selector(settlementSuccess)]) {
                            [ShellCoinUserInfo shareUserInfos].aviableBalance = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue] -[self.dataModel.totalAmount doubleValue]];
                            [[JAlertViewHelper shareAlterHelper]showTint:@"结算成功" duration:2.];
                            [self.delegate settlementSuccess];
                            [self removeFromSuperview];
                        }
                    }
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [SVProgressHUD dismiss];
                    [[JAlertViewHelper shareAlterHelper]showTint:@"结算失败，请稍后重试" duration:2.];
                }];

            }];
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];

            
            
            }
            break;
            
        case payway_type_alipay:
        {
            NSDictionary *parms = @{@"settleId":self.dataModel.orderId,
                                    @"token":[ShellCoinUserInfo shareUserInfos].token};
            [AliPayObject startAliPayMerchantJiesuan:parms];
        }
            break;
        default:
            break;
    }
    
}
//取消
- (IBAction)cancelBtn:(UIButton *)sender {
        [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(310/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end
