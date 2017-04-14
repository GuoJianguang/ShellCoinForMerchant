//
//  HomeViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "WaitSureOrderCell.h"
#import "StateMentsMViewController.h"
#import "OrderEntryViewController.h"
#import "OrderManamentViewController.h"
#import "MyQRCodeViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hidden = YES;
    

    [self.tableView noDataSouce];
    //自动登录
    if ([ShellCoinUserInfo shareUserInfos].currentLogined) {
        [self getRequest];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin) name:AutoLoginAfterGetDeviceToken object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //自动登录
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AutoLoginAfterGetDeviceToken object:nil];
}


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
                [self getRequest];
                return ;
            }
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsFirstLaunch
             ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            UINavigationController *logvc = [LoginViewController controller];
            [self presentViewController:logvc animated:YES completion:NULL];
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            UINavigationController *logvc = [LoginViewController controller];
            [self presentViewController:logvc animated:YES completion:NULL];
        }];
    }
}



- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}



#pragma mark - 获取数据接口
- (void)getRequest
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient GET:@"mch/biz/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.todaOrder.text = NullToNumber(jsonObject[@"data"][@"orderCount"]);
            [self.dataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"][@"orderList"];
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[WaitSureOrderModel modelWithDic:dic]];
            }
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView showNoDataSouceNoNetworkConnection];
    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitSureOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[WaitSureOrderCell indentify]];
    if (!cell) {
        cell = [WaitSureOrderCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(190/750.);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderManamentViewController *orderManaMentVC = [[OrderManamentViewController alloc]init];
    [self.navigationController pushViewController:orderManaMentVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 结算单管理
- (IBAction)jiesuandanBtn:(UIButton *)sender {
    StateMentsMViewController *stateMVC = [[StateMentsMViewController alloc]init];
    [self.navigationController pushViewController:stateMVC animated:YES];
}

#pragma mark - 订单管理
- (IBAction)orderManangeBtn:(UIButton *)sender {
    OrderManamentViewController *orderManaMentVC = [[OrderManamentViewController alloc]init];
    [self.navigationController pushViewController:orderManaMentVC animated:YES];
    
}

- (IBAction)orderEnter:(UIButton *)sender {
    OrderEntryViewController *orderENtryVC = [[OrderEntryViewController alloc]init];
    [self.navigationController pushViewController:orderENtryVC animated:YES];
}

#pragma mark - 二维码和退出登录

- (IBAction)qrCode:(UIButton *)sender {
    MyQRCodeViewController *myQRVC = [[MyQRCodeViewController alloc]init];
    [self.navigationController pushViewController:myQRVC animated:YES];
    
}

- (IBAction)logOut:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *titles = @[@"退出"];
    [self addActionTarget:alert titles:titles];
    [self addCancelActionTarget:alert title:@"取消"];
    // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:15];
    [appearanceLabel setFont:font];
    [self presentViewController:alert animated:YES completion:nil];
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
            [self presentViewController:[[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"] animated:YES completion:^{
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
