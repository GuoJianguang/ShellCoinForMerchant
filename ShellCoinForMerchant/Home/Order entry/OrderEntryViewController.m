//
//  OrderEntryViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderEntryViewController.h"

@interface OrderEntryViewController ()<BasenavigationDelegate,UITextFieldDelegate>

@end

@implementation OrderEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"订单录入";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    
    self.amountTF.delegate = self;
    self.phoneTF.delegate = self;
    
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}

#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
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
    if (self.phoneTF == textField && textField.text.length > 10 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    if (self.amountTF == textField) {
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
        if (textField.text.length > 14 && ![string isEqualToString:@""]&& ![string isEqualToString:@" "]) {
            return NO;
        }
        return YES;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTF && textField.text.length == 11) {
        NSDictionary *parms = @{@"phone":self.phoneTF.text,
                                @"token":[ShellCoinUserInfo shareUserInfos].token};
        [HttpClient POST:@"mch/userIdcardName/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                switch ([jsonObject[@"data"][@"flag"] integerValue]) {
                    case 0:{
                        [self.markBtn setTitle:@"未注册用户" forState:UIControlStateNormal];
                        [self.markBtn setTitleColor:MacoColor forState:UIControlStateNormal];
                    }
                        break;
                    case 1:{
                        [self.markBtn setTitle:@"未认证用户" forState:UIControlStateNormal];
                        [self.markBtn setTitleColor:MacoColor forState:UIControlStateNormal];
                    }
                        break;
                    case 2:{
                        [self.markBtn setTitle:NullToSpace(jsonObject[@"data"][@"idcardName"]) forState:UIControlStateNormal];
                        [self.markBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"号码查询失败，请重新输入或稍后重试" duration:2.5];
        }];
        
        return;
        
    }
    [self.markBtn setTitle:@"" forState:UIControlStateNormal];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.phoneTF resignFirstResponder];
    [self.amountTF resignFirstResponder];
}


#pragma mark - 确认录入
- (void)detailBtnClick
{
    if ([self valueValidated]) {
        
        NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.amountTF.text doubleValue]];
        NSDictionary *parms = @{@"phone":self.phoneTF.text,
                                @"tranAmount":totalMoney,
                                @"token":[ShellCoinUserInfo shareUserInfos].token};
        
        [SVProgressHUD showWithStatus:@"正在录入..." maskType:SVProgressHUDMaskTypeBlack];
        [HttpClient POST:@"mch/consumeInput" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"录入订单成功" duration:2.0];
                self.phoneTF.text = @"";
                self.amountTF.text  = @"";
                [self.markBtn setTitle:@"" forState:UIControlStateNormal];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
        
    }
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.phoneTF] ) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入录入电话号码" duration:2.];
        return NO;
    }else if (self.phoneTF.text.length!=11|| ![[self.phoneTF.text substringToIndex:1] isEqualToString:@"1"]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的电话号码" duration:2.];
        return NO;
    }else if ([self emptyTextOfTextField:self.amountTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入录入金额" duration:2.];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
