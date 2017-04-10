//
//  OrderManamentViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderManamentViewController.h"
#import "Bill1View.h"
#import "Bill12View.h"
#import "SureOrderView.h"

@interface OrderManamentViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)Bill1View *waitSureOrderView;
@property (nonatomic, strong)Bill12View *yetSureOrderView;

@property (nonatomic, strong)SureOrderView *sureOrderView;

@end

@implementation OrderManamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sortView.titleArray = @[@"待确认订单",@"已完成订单"];
    self.sortView.delegate = self;
    self.naviBar.hidden = YES;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (Bill1View *)waitSureOrderView
{
    if (!_waitSureOrderView) {
        _waitSureOrderView = [[Bill1View alloc]init];
    }
    return _waitSureOrderView;
}

- (Bill12View *)yetSureOrderView
{
    if (!_yetSureOrderView) {
        _yetSureOrderView  =[[Bill12View alloc]init];
    }
    return _yetSureOrderView;
}

- (SureOrderView *)sureOrderView
{
    if (!_sureOrderView) {
        _sureOrderView = [[SureOrderView alloc]init];
    }
    return _sureOrderView;
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
            [view addSubview:self.waitSureOrderView];
            [self.waitSureOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.yetSureOrderView];
            [self.yetSureOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
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
            [self.waitSureOrderView reload];
            break;
        case 1:
            [self.yetSureOrderView reload];
            break;
        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
}



- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 确认订单

- (void)sureOrder:(NSString *)orerId
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.navigationController.view addSubview:self.sureOrderView];
    [self.sureOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view).insets(insets);
    }];
}

@end