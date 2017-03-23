//
//  ForgetPasswordTwoViewController.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "ForgetPasswordTwoViewController.h"

@interface ForgetPasswordTwoViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviBar.title = @"忘记密码";
    self.naviBar.title_label.textColor = [UIColor whiteColor];
    self.naviBar.lineVIew.hidden = YES;
    self.naviBar.backImage = [UIImage imageNamed:@"icon_back_white"];
    self.bgimage.image = [UIImage imageNamed:@"bg_login.jpg"];
    self.imageHeight.constant = TWitdh*(66/75.);
    self.loginWidth.constant = TWitdh*(526/750.);

    
    self.password_view.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.password_view.layer.masksToBounds = YES;
    self.password_view.layer.borderWidth = 1;
    self.password_view.layer.borderColor = MacolayerColor.CGColor;
    
    self.surePassword_view.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.surePassword_view.layer.masksToBounds = YES;
    self.surePassword_view.layer.borderWidth = 1;
    self.surePassword_view.layer.borderColor = MacolayerColor.CGColor;
    
    self.sureWidth.constant = TWitdh*(400/750.);
    CGFloat  sureBtnWidth = TWitdh*(400/750.);
    self.login_btn.bounds = CGRectMake(0, 0, sureBtnWidth, sureBtnWidth/5.);
    self.login_btn.layer.cornerRadius = self.login_btn.bounds.size.height/2.;
    self.login_btn.layer.masksToBounds = YES;
    self.login_btn.backgroundColor = MacoColor;
    
    
    if (THeight < 500) {
        //        self.userTop.constant = 0;
//        self.loginTop.constant = 20;
        self.imageHeight.constant = TWitdh*(50/75.);
        self.bgimage.contentMode = UIViewContentModeScaleAspectFill;
        self.bgimage.layer.masksToBounds = YES;
    }
    
    
    self.password_tf.delegate = self;
    self.surePassword_tf.delegate = self;
    
    
    

}
- (IBAction)login_btn:(UIButton *)sender
{
    [self.password_tf resignFirstResponder];
    [self.surePassword_tf resignFirstResponder];
    if ([self valueValidated]) {
        //忘记密码接口请求
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.password_tf.text,PasswordKey]md5_32];
        NSDictionary *parms = @{@"phone":self.userName,
                                @"verifyCode":self.verifyCode,
                                @"password":password};
        [HttpClient POST:@"user/findPassword" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [SVProgressHUD showSuccessWithStatus:@"找回密码成功,请重新登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        }];
    }
}

-(BOOL) valueValidated {
    if ([self emptyTextOfTextField:self.password_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入密码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.surePassword_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请确认密码" duration:1.];
        return NO;
    }else if (![self.password_tf.text isEqualToString:self.surePassword_tf.text]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"两次输入的密码不一致" duration:1.];
        return NO;
    }else if (self.password_tf.text.length < 6 || self.surePassword_tf.text.length < 6){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的密码长度不能小于6位" duration:1.];
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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.password_tf resignFirstResponder];
    [self.surePassword_tf resignFirstResponder];
}


#pragma mark - UITextFeld
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.password_tf) {
        self.password_view.layer.borderColor = MacoColor.CGColor;
    }
    if (textField == self.surePassword_tf) {
        self.surePassword_view.layer.borderColor = MacoColor.CGColor;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.password_tf) {
        self.password_view.layer.borderColor = MacolayerColor.CGColor;
    }
    if (textField == self.surePassword_tf) {
        self.surePassword_view.layer.borderColor = MacolayerColor.CGColor;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
