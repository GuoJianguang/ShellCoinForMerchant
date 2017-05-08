//
//  SettlementPayWayView.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StateMentDataModel;

typedef NS_ENUM(NSInteger,Payway_type){
    Payway_type_banlance = 1,//余额支付
    Payway_type_wechat = 2,//微信支付
    payway_type_alipay = 3//支付宝支付
};


@protocol SettlementDelegate <NSObject>

- (void)settlementSuccess;

@end
@interface SettlementPayWayView : UIView

- (void)tap;

@property (weak, nonatomic) IBOutlet UIView *blackBackgoundView;


@property (weak, nonatomic) IBOutlet UIView *itemView;





@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *yuEMarkBtn;
- (IBAction)yuEBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *yuEbtn;
@property (weak, nonatomic) IBOutlet UIImageView *yuEImage;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UIButton *wechatMarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
- (IBAction)wechatBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *aliPayImage;
@property (weak, nonatomic) IBOutlet UILabel *aliPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *aliPayMarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPaytBtn;
- (IBAction)aliPay:(UIButton *)sender;

//支付方式
@property (nonatomic, assign)Payway_type payWay_type;

//结算金额
@property (nonatomic, copy)NSString *money;

@property (nonatomic, strong)StateMentDataModel *dataModel;

@property (nonatomic, assign)id<SettlementDelegate> delegate;

@end
