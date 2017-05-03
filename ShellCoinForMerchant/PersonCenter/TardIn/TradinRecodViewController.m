//
//  TradinRecodViewController.m
//  ShellCoinForMerchant
//
//  Created by mac on 2017/5/3.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TradinRecodViewController.h"
#import "BillTableViewCell.h"

@interface TradinRecodViewController ()
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@property (nonatomic, assign)NSInteger page;
@end

@implementation TradinRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"提现明细";
    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self alldetailReqest:YES];
    }];
    self.tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self alldetailReqest:NO];
    }];
    self.tabView.backgroundColor  = [UIColor clearColor];

    [self.tabView noDataSouce];
    [self.tabView.mj_header beginRefreshing];
}


- (void)alldetailReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":@"20",
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient GET:@"mch/withdraw/list" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.datasouceArray removeAllObjects];
                [self.tabView.mj_header endRefreshing];
            }
            [self.tabView.mj_footer endRefreshing];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.datasouceArray addObject:[TixianRecodModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.tabView reloadData];
            [self.tabView judgeIsHaveDataSouce:self.datasouceArray];
            return ;
        }
        if (isHeader) {
            [self.tabView.mj_header endRefreshing];
        }else{
            [self.tabView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tabView.mj_header endRefreshing];
        [self.tabView.mj_footer endRefreshing];
        [self.tabView showNoDataSouceNoNetworkConnection];
        
    }];
}


- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.datasouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TWitdh > 320.) {
        return (TWitdh-48)*(184/750.);
    }
    return (TWitdh-48)*(220/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillTableViewCell indentify]];
    if (!cell) {
        cell = [BillTableViewCell newCell];
    }
    cell.recodModel = self.datasouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
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
