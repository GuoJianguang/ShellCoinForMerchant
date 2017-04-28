//
//  SureTradInView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureTradInView.h"
#import "ForgetPasswordOneViewController.h"

@interface SureTradInView()

@end
@implementation SureTradInView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureTradInView" owner:nil options:nil][0];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self sendSubviewToBack:self.blackBackgoundView];
        self.passwordTF.layer.cornerRadius = (TWitdh-120) *(8/52.)/2.;
        self.passwordTF.layer.borderWidth =1;
        self.passwordTF.layer.borderColor = MacoColor.CGColor;
        self.passwordTF.textColor = MacoColor;
        self.passwordTF.layer.masksToBounds = YES;
        [self.forgetBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];
        
        [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}
- (IBAction)cancelBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
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

- (void)setMallOrderParms:(NSMutableDictionary *)mallOrderParms
{
    _mallOrderParms = mallOrderParms;
}

- (IBAction)sureBtn:(UIButton *)sender {
    
    
    if ([self.passwordTF.text isEqualToString:@""] || !self.passwordTF.text) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入支付密码" duration:1.5];
        return ;
    }
    [self.passwordTF resignFirstResponder];
    
    [self getWithDrawRequest:sender];

}

- (IBAction)forgetBtn:(UIButton *)sender {
    
    ForgetPasswordOneViewController *changPayVC = [[ForgetPasswordOneViewController alloc]init];
    [self.viewController.navigationController pushViewController:changPayVC animated:YES];
}


#pragma mark - 提现的接口请求

- (void)getWithDrawRequest:(UIButton *)sender
{
    //提现的接口请求
    NSString *password = [[NSString stringWithFormat:@"%@%@",self.passwordTF.text,PasswordKey]md5_32];
    [self.mallOrderParms setObject:password forKey:@"password"];
    [SVProgressHUD showWithStatus:@"正在提交申请"];
    [HttpClient POST:@"mch/withdraw/withdrawReq" parameters:self.mallOrderParms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        sender.enabled = YES;
        if (IsRequestTrue) {
            [ShellCoinUserInfo shareUserInfos].aviableBalance = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue] - [NullToNumber(self.mallOrderParms[@"withdrawAmount"]) doubleValue]];
            if ([self.delegate respondsToSelector:@selector(paysuccess:)]) {
                [self.delegate paysuccess:self.mallOrderParms[@"withdrawAmount"]];
            }
            [self removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"提现请求失败，请稍后重试" duration:2.0];
        sender.enabled = YES;
        [SVProgressHUD dismiss];
    }];
}




@end
