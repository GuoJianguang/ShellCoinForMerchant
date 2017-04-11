//
//  Bill1View.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "Bill12View.h"
#import "BillAmountDataModel.h"
#import "YetCompleteOrderCell.h"

@interface Bill12View()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end



@implementation Bill12View


- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"Bill12View" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak Bill12View *weak_self = self;
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

- (void)getxiaofeijiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoPageSize,
                            @"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"flag":@"2"};
    [HttpClient POST:@"mch/order/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                BillAmountDataModel *model = [BillAmountDataModel modelWithDic:dic];
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
    YetCompleteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[YetCompleteOrderCell indentify]];
    if (!cell) {
        cell = [YetCompleteOrderCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
