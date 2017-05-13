//
//  StateMentsMViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "StateMentsMViewController.h"
#import "StateMentTableViewCell.h"
#import "SettlementPayWayView.h"
#import "WeXinPayObject.h"

@interface StateMentsMViewController ()<UITableViewDelegate,UITableViewDataSource,SettlementDelegate,BasenavigationDelegate>
@property (nonatomic, strong)SettlementPayWayView *payView;

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation StateMentsMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"结算单管理";
    self.naviBar.delegate = self;
    __weak StateMentsMViewController *weak_self = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getRequest:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequest:NO];
    }];
    [self.tableView noDataSouce];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.alerLabel1.textColor = MacoColor;
    self.alerLabel2.textColor = MacoDetailColor;
    self.alerLabel1.text = @"手动打款说明";
    self.alerLabel2.text = @"对公账户：中国民生银行 成都领创有你科技有限公司\n开户行：成都神仙树支行  6232 5820 0035 4518\n\n对私账户：中国民生银行 6226 1920 0526 3926 韩旭\n开户行：成都神仙树支行";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aliPayResult:) name:AliPayResult object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weixinPayResult:) name:WeixinPayResult object:nil];


}

- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AliPayResult" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
- (SettlementPayWayView *)payView
{
    if (!_payView) {
        _payView = [[SettlementPayWayView alloc]init];
        _payView.delegate = self;
    }
    return _payView;
}

- (void)getRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoPageSize,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"mch/settle/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                StateMentDataModel *model = [StateMentDataModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView showNoDataSouceNoNetworkConnection];
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
            
        }
    }];
}


#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateMentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StateMentTableViewCell indentify]];
    if (!cell) {
        cell = [StateMentTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateMentDataModel *model = self.dataSouceArray[indexPath.row];
    if ([model.state isEqualToString:@"1"]) {
        return TWitdh *(350/750.) - 38;
    }
    return TWitdh *(310/750.);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateMentDataModel *model = self.dataSouceArray[indexPath.row];
    if ([model.state isEqualToString:@"1"]) {
        return;
    }
    
    [self.view addSubview:self.payView];
    self.payView.dataModel = model;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.payView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(310/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.payView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(310/375.)), TWitdh, TWitdh*(310/375.));
    }];

}

#pragma mark - 支付宝结算结果
- (void)aliPayResult:(NSNotification *)notification{
    
    switch ([notification.userInfo[@"resultStatus"] integerValue]) {
        case 9000:
        {
            [[JAlertViewHelper shareAlterHelper]showTint:@"结算成功" duration:2.];
            [self.payView tap];
            [self settlementSuccess];
        }
            break;
        case 8000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态" duration:2.];

            break;
        case 4000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"订单支付失败" duration:2.];

            break;
        case 5000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"重复请求" duration:2.];

            break;
        case 6001:
            [[JAlertViewHelper shareAlterHelper]showTint:@"用户中途取消" duration:2.];

            break;
        case 6002:
            [[JAlertViewHelper shareAlterHelper]showTint:@"网络连接出错" duration:2.];

            break;
        case 6004:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态" duration:2.];

            break;
            
        default:
            break;
    }
    
}

#pragma mark - 微信支付结算结果


- (void)weixinPayResult:(NSNotification *)notification
{
    NSString *code = notification.userInfo[@"resultcode"];
    switch ([code intValue]) {
        case WXSuccess:
        {
            [[JAlertViewHelper shareAlterHelper]showTint:@"结算成功" duration:2.];
            [self.payView tap];
            [self settlementSuccess];
        }
            
            break;
        case WXErrCodeCommon:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];
            
            break;
        case WXErrCodeUserCancel:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您已取消支付" duration:2.];
            
            break;
        case WXErrCodeSentFail:
            [[JAlertViewHelper shareAlterHelper]showTint:@"发起支付请求失败" duration:2.];
            
            break;
        case WXErrCodeAuthDeny:
            [[JAlertViewHelper shareAlterHelper]showTint:@"微信支付授权失败" duration:2.];
            break;
        case WXErrCodeUnsupport:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您未安装微信客户端,请先安装" duration:2.];
            break;
        default:
            break;
    }
}

- (void)settlementSuccess
{
    [self.tableView.mj_header beginRefreshing];
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
