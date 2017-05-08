//
//  PersonCenterTableViewCell.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "PersonCenterTableViewCell.h"
#import "TradeInViewController.h"
#import "MessageListViewController.h"
#import "AboutUSViewController.h"
#import "BillViewController.h"

@implementation PersonCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.wirhDrawBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.label1.textColor = self.label2.textColor = self.label3.textColor = MacoDetailColor;
    self.incomeLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
    self.spendingLabel.textColor = [UIColor colorFromHexString:@"#45de8e"];

    self.balance.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    
    
    [self getInfoMation];
    
}


- (void)getInfoMation
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token};
        [HttpClient POST:@"mch/wallet" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                NSString *balance = NullToNumber(jsonObject[@"data"][@"balance"]);
                [ShellCoinUserInfo shareUserInfos].aviableBalance = balance;
                self.balance.text = [NSString stringWithFormat:@"%.2f",[balance doubleValue]];
                if ([NullToNumber(jsonObject[@"data"][@"messageCount"]) isEqualToString:@"0"]) {
                     [self.messageBtn setImage:[UIImage imageNamed:@"icon_news"] forState:UIControlStateNormal];
                }else{
                    [self.messageBtn setImage:[UIImage imageNamed:@"icon_news_remind"] forState:UIControlStateNormal];

                }

            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)messageBtn:(UIButton *)sender {
    MessageListViewController *messageVC =[[MessageListViewController alloc]init];
    [self.viewController.navigationController pushViewController:messageVC animated:YES];
}
- (IBAction)wirhDrawBtn:(UIButton *)sender {
    TradeInViewController *tradeInVC =[[TradeInViewController alloc]init];
    [self.viewController.navigationController pushViewController:tradeInVC animated:YES];
}
- (IBAction)cleanBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"正在清除..."];
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
        //        NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
        [SVProgressHUD showSuccessWithStatus:@"清除完毕"];
        
    }];
}

- (IBAction)aboutUSBtn:(id)sender {
    AboutUSViewController *aboutUsVC = [[AboutUSViewController alloc]init];
    [self.viewController.navigationController pushViewController:aboutUsVC animated:YES];
}

- (IBAction)logoutBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *titles = @[@"退出"];
    [self addActionTarget:alert titles:titles];
    [self addCancelActionTarget:alert title:@"取消"];
    // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:15];
    [appearanceLabel setFont:font];
    [self.viewController presentViewController:alert animated:YES completion:nil];

}
- (IBAction)incomeBtn:(id)sender {
    BillViewController *billVC = [[BillViewController alloc]init];
    billVC.billtype = BillType_income;
    [self.viewController.navigationController pushViewController:billVC animated:YES];
}
- (IBAction)spendingBtn:(id)sender {
    BillViewController *billVC = [[BillViewController alloc]init];
    billVC.billtype = BillType_spending;
    [self.viewController.navigationController pushViewController:billVC animated:YES];
}


#pragma mark - 退出登录的方法

// 添加其他按钮
- (void)addActionTarget:(UIAlertController *)alertController titles:(NSArray *)titles
{
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [HttpClient POST:@"user/logout" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            }];
            [ShellCoinUserInfo shareUserInfos].currentLogined = NO;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:LoginUserPassword];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch];
            //统计新增用户
            [MobClick profileSignOff];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //            [[NSNotificationCenter defaultCenter]postNotificationName:LogOutNSNotification object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self.viewController.navigationController name:Upush_Notifi object:nil];
            [self.viewController presentViewController:[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"] animated:YES completion:^{
            }] ;
            
        }];
        [action setValue:MacoColor forKey:@"_titleTextColor"];
        [alertController addAction:action];
    }
}

// 取消按钮
- (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:MacoTitleColor forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

@end
