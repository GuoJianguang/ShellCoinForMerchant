//
//  LoginViewController.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/28.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterOneViewController.h"
#import "ForgetPasswordOneViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;

    self.imageHeight.constant = TWitdh*(72/75.);
    
    self.loginWidth.constant = TWitdh*(526/750.);
    
    self.user_view.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.user_view.layer.masksToBounds = YES;
    self.user_view.layer.borderWidth = 1;
    self.user_view.layer.borderColor = MacolayerColor.CGColor;
    
    self.password_view.layer.cornerRadius =  (self.loginWidth.constant*(88/526.))/2.;
    self.password_view.layer.masksToBounds = YES;
    self.password_view.layer.borderWidth = 1;
    self.password_view.layer.borderColor = MacolayerColor.CGColor;
    
    self.sureWidth.constant = TWitdh*(400/750.);
    CGFloat  sureBtnWidth = TWitdh*(400/750.);
    self.login_btn.bounds = CGRectMake(0, 0, sureBtnWidth, sureBtnWidth/(177/594.));
//    self.login_btn.layer.cornerRadius = self.login_btn.bounds.size.height/2.;
    self.login_btn.layer.masksToBounds = YES;
//    self.login_btn.backgroundColor = MacoColor;
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName]) {
        self.user_tf.text = [[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName];
    }
    self.password_tf.delegate = self;
    self.user_tf.delegate = self;
    
    if (THeight < 500) {
//        self.userTop.constant = 0;
        self.loginTop.constant = 10;
        self.imageHeight.constant = TWitdh*(55/75.);
        self.imageView.layer.masksToBounds = YES;
        self.bgimage.contentMode = UIViewContentModeScaleAspectFill;
        self.bgimage.layer.masksToBounds = YES;
    }
}

- (IBAction)login_btn:(UIButton *)sender
{
    [self.user_tf resignFirstResponder];
    [self.password_tf resignFirstResponder];
    if ([self valueValidated]) {
        [SVProgressHUD showWithStatus:@"正在登录..."];
        //登录接口请求操作
        NSString *password = [[NSString stringWithFormat:@"%@%@",self.password_tf.text,PasswordKey]md5_32];
        
        NSDictionary *parms = @{@"phone":self.user_tf.text,
                                @"deviceToken":[ShellCoinUserInfo shareUserInfos].devicetoken,
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"mch/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                //设置用户信息
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:self.user_tf.text forKey:LoginUserName];
                [[NSUserDefaults standardUserDefaults]setObject:self.password_tf.text forKey:LoginUserPassword];
                [[NSUserDefaults standardUserDefaults]setObject:self.password_tf.text forKey:LoginUserPassword];
                [ShellCoinUserInfo shareUserInfos].currentLogined = YES;
                [[ShellCoinUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //记录商户号
                [[NSUserDefaults standardUserDefaults]setObject:[ShellCoinUserInfo shareUserInfos].code forKey:MyBussinssCode];
                
                //统计新增用户
                [MobClick profileSignInWithPUID:[ShellCoinUserInfo shareUserInfos].userid];
                [[NSUserDefaults standardUserDefaults]synchronize];
//
                
//                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Main"];
//                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                [self presentViewController:[UIApplication sharedApplication].keyWindow.rootViewController animated:YES completion:NULL];
//
//                return ;
                if (![[NSUserDefaults standardUserDefaults]objectForKey:IsFirstLaunch]) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Main"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsFirstLaunch];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [self presentViewController:[UIApplication sharedApplication].keyWindow.rootViewController animated:YES completion:NULL];
                }else{
                    [self dismissViewControllerAnimated:YES completion:NULL];
                }
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }

}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.user_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入用户名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.password_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入密码" duration:1.];
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
    [self.user_tf resignFirstResponder];
    [self.password_tf resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.user_tf) {
        self.user_view.layer.borderColor = MacoColor.CGColor;
    }
    if (textField == self.password_tf) {
        self.password_view.layer.borderColor = MacoColor.CGColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.user_tf) {
        self.user_view.layer.borderColor = MacolayerColor.CGColor;
    }
    if (textField == self.password_tf) {
        self.password_view.layer.borderColor = MacolayerColor.CGColor;
    }
}

#pragma mark - 获取登录模块
+ (UINavigationController *)controller
{
    return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];
}


- (IBAction)forgetBtn:(id)sender {
    ForgetPasswordOneViewController *forgetVC = [[ForgetPasswordOneViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (IBAction)registerBtn:(id)sender {
    RegisterOneViewController *registerVC = [[RegisterOneViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)cancelLogin:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
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
