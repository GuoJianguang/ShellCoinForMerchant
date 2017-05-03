//
//  TradeInViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TradeInViewController.h"
#import "SureTradInView.h"
#import "WithDrawalResultView.h"

@interface TradeInViewController ()<UITextFieldDelegate,PayViewDelegate>
@property (nonatomic, strong)SureTradInView *passwordView;
@property (nonatomic,strong)WithDrawalResultView *resultView;
@end

@implementation TradeInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.canWithDrawMoney.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    self.moneyTF.delegate = self;
    self.canWithDrawMoney.adjustsFontSizeToFitWidth = YES;
    self.naviBar.hidden = YES;
    [self.moneyTF becomeFirstResponder];
    if (TWitdh == 320) {
        self.inputMoneyViewHeight.constant = (TWitdh - 44)*(350/686.);
    }else{
        self.inputMoneyViewHeight.constant = (TWitdh - 44)*(300/686.);

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (SureTradInView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[SureTradInView alloc]init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}

- (WithDrawalResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[WithDrawalResultView alloc]init];
    }
    return _resultView;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sureBtn:(UIButton *)sender {

    if ([self balueValideted]) {
        [self.moneyTF resignFirstResponder];
        [self goinputPassword];
    }
}

- (void)goinputPassword
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"withdrawAmount":self.moneyTF.text};
    [self.view addSubview:self.passwordView];
    self.passwordView.passwordTF.text = @"";
    self.passwordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:parms];
    self.passwordView.inputType = Password_type_withdraw;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.passwordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}


- (BOOL)balueValideted
{
    if ([self emptyTextOfTextField:self.moneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入提现金额" duration:1.];
        return NO;
    }else if ([self.canWithDrawMoney.text doubleValue] < [self.moneyTF.text doubleValue]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可提现余额不足，请重新输入" duration:1.5];
        return NO;
    }else if ([self.moneyTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额必须是10的整数倍" duration:1.5];
        return NO;
    }else if ([self.moneyTF.text integerValue] <1000){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的提现金额不能小于1000" duration:1.5];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.moneyTF) {
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        
        if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
        {
            return NO;
        }
        
        short remain = 2; //默认保留2位小数
        
        NSString *tempStr = [textField.text stringByAppendingString:string];
        NSUInteger strlen = [tempStr length];
        if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
            if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
                return NO;
            }
            if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return NO;
            }
        }
        
        NSRange zeroRange = [textField.text rangeOfString:@"0"];
        if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
            if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string;
                return NO;
            }else{
                if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if([string isEqualToString:@"0"]){
                        return NO;
                    }
                }
            }
        }
        NSString *buffer;
        if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
        {
            return NO;
        }
    }
    return YES;
}

- (void)paysuccess:(NSString *)payWay
{
    self.canWithDrawMoney.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    [self.view addSubview:self.resultView];
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",payWay];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

@end
