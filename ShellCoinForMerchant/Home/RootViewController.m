//
//  RootViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RootViewController.h"

static NSString *infomation  = @"infomation";//消息列表
static NSString *settle  = @"settle";//结算统计
static NSString *withdraw  = @"withdraw";//账户提现
static NSString *account  = @"account";//账户收入
static NSString *mchWaitDeliver  = @"mchWaitDeliver";//待发货
static NSString *hasComplete  = @"hasComplete";//已完成

@interface RootViewController ()<UIAlertViewDelegate>
@property (nonatomic, copy)NSString *turnType;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //接收的推送
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fanxian:) name:Upush_Notifi object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin) name:AutoLoginAfterGetDeviceToken object:nil];

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;  //默认的值是黑色的
}


#pragma mark - 当进入程序有推送的时候执行此方法
- (void)notifica:(NSDictionary *)notifiInfo
{
    if ([ShellCoinUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(notifiInfo[@"page"]);
        NSString *alerInfo = NullToSpace(notifiInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:settle]&&![self.turnType isEqualToString:withdraw]&&![self.turnType isEqualToString:account]&&![self.turnType isEqualToString:mchWaitDeliver]&&![self.turnType isEqualToString:hasComplete]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [showView show];
            showView.tag = 20;
            return;
        }
        [self getRefrshOrderInfo];
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        showView.tag = 10;
        [showView show];
    }
}

//接收返现信息的推送
- (void)fanxian:(NSNotification *)faication
{
    if ([ShellCoinUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(faication.userInfo[@"page"]);
        NSString *alerInfo = NullToSpace(faication.userInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:settle]&&![self.turnType isEqualToString:withdraw]&&![self.turnType isEqualToString:account]&&![self.turnType isEqualToString:hasComplete]&&![self.turnType isEqualToString:mchWaitDeliver]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            showView.tag = 20;
            
            [showView show];
            return;
        }
        [self getRefrshOrderInfo];
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        showView.tag = 10;
        [showView show];
    }
}
//账户提现信息推送

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 && buttonIndex == 1) {
        if ([self.turnType isEqualToString:infomation]) {//消息列表

        }else if([self.turnType isEqualToString:withdraw]){//账户提现

        }else if([self.turnType isEqualToString:settle]){//结算统计

        }else if([self.turnType isEqualToString:hasComplete]){//商城订单已完成
//            if ([self.topViewController isKindOfClass:[MallOrderViewController class]]) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"notificationyetComplet" object:nil userInfo:nil];
            
                return;
//            }
//            MallOrderViewController *mallVC = [[MallOrderViewController alloc]init];
//            mallVC.orderType = MallOrderRequetst_yetComplete;
//            [self pushViewController:mallVC animated:YES];
        }
        return;
    }else if(alertView.tag == 20){
        return;
    }else if(alertView.tag == 10 && buttonIndex == 0){
        return;
    }else{
        //去登录
        UINavigationController *logvc = [LoginViewController controller];
        [self presentViewController:logvc animated:YES completion:NULL];
    }
}

#pragma mark - 自动登录
- (void)autoLogin
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword]) {
        NSString *password = [[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword],PasswordKey]md5_32];
        NSDictionary *parms = @{
                                @"phone":[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName],
                                @"deviceToken":[ShellCoinUserInfo shareUserInfos].devicetoken,
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"mch/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                //设置用户信息
                [ShellCoinUserInfo shareUserInfos].currentLogined = YES;
                [[ShellCoinUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //统计新增用户
                [MobClick profileSignInWithPUID:[ShellCoinUserInfo shareUserInfos].userid];
                if ([ShellCoinUserInfo shareUserInfos].islaunchFormNotifi) {
                    [self notifica:[ShellCoinUserInfo shareUserInfos].notificationParms];
                    [ShellCoinUserInfo shareUserInfos].islaunchFormNotifi = NO;
                }
                return ;
            }
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch
             ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //接收的推送
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Upush_Notifi object:nil];
    //自动登录
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AutoLoginAfterGetDeviceToken object:nil];
}


#pragma mark - 更新本地订单数据
- (void)getRefrshOrderInfo
{
    //    self.navigationController
    NSDictionary *parms = @{@"code":NullToSpace([ShellCoinUserInfo shareUserInfos].code)};
    [HttpClient GET:@"mch/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if ([jsonObject[@"data"][@"unreadMchMsgCountVo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *unreadMsgCountVo = jsonObject[@"data"][@"unreadMchMsgCountVo"];
                [ShellCoinUserInfo shareUserInfos].messageCount = NullToNumber(unreadMsgCountVo[@"messageCount"]);
                [ShellCoinUserInfo shareUserInfos].withdrawCount = NullToNumber(unreadMsgCountVo[@"withdrawCount"]);
//                [ShellCoinUserInfo shareUserInfos].settleCount = NullToNumber(unreadMsgCountVo[@"settleCount"]);
//                [ShellCoinUserInfo shareUserInfos].hasDeliveredCount = NullToNumber(unreadMsgCountVo[@"hasDeliveredCount"]);
//                [ShellCoinUserInfo shareUserInfos].shopCompleteCount = NullToNumber(unreadMsgCountVo[@"shopCompleteCount"]);
//                [ShellCoinUserInfo shareUserInfos].waitDeliverCount = NullToNumber(unreadMsgCountVo[@"waitDeliverCount"]);
//                [ShellCoinUserInfo shareUserInfos].accountCount = NullToNumber(unreadMsgCountVo[@"accountCount"]);
            }
            [ShellCoinUserInfo shareUserInfos].bindingFlag = NullToNumber(jsonObject[@"data"][@"bankAccountFlag"]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

@end
