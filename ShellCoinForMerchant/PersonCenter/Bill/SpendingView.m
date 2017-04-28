//
//  SpendingView.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SpendingView.h"
#import "TixianModel.h"
#import "BillTableViewCell.h"

@interface SpendingView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end
@implementation SpendingView

- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SpendingView" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak SpendingView *weak_self = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
            [weak_self getxiaofeijiluRequest:YES];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getxiaofeijiluRequest:NO];
        }];
        [self.tableView noDataSouce];
        [self reload];
    }
    return self;
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (void)getxiaofeijiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoPageSize,
                            @"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"type":@"2"};
    [HttpClient POST:@"mch/account/inandout" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                TixianModel *model = [TixianModel modelWithDic:dic];
                model.billType = 1;
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
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSouceArray.count;
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
    cell.tixianModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
