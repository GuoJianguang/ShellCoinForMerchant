//
//  BillViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillViewController.h"
#import "IncomeView.h"
#include "SpendingView.h"

@interface BillViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)SpendingView *spendingView;
@property (nonatomic, strong)IncomeView *incomeView;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    self.sortView.titleArray = @[@"收入",@"支出"];

    if (self.billtype == BillType_spending) {
        [self.swipeView scrollToPage:1 duration:0.1];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  
}

- (SpendingView *)spendingView
{
    if (!_spendingView) {
        _spendingView = [[SpendingView alloc]init];
    }
    return _spendingView;
}

- (IncomeView *)incomeView
{
    if (!_incomeView) {
        _incomeView = [[IncomeView alloc]init];
    }
    return _incomeView;
}

- (IBAction)backBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SortViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    [self.swipeView scrollToPage:[sortId integerValue] -1 duration:0.5];
    
}
#pragma mark - SwipeView
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, swipeView.frame.size.width, swipeView.frame.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 0:{
            [view addSubview:self.incomeView];
            [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.spendingView];
            [self.spendingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
            
        }
            break;
            
            
        default:
            break;
    }
    
    return view;
}
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 2;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    switch (swipeView.currentPage) {
        case 0:
            [self.incomeView reload];
            break;
        case 1:
            [self.spendingView reload];
            break;
        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
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
