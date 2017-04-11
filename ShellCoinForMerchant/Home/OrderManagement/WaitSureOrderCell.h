//
//  BillConsumptionTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitSureOrderModel : BaseModel
/**
 * 渠道  1线下现金消费 2线下微信消费 3线下余额消费
 */
@property (nonatomic, copy)NSString *channel;
/**
 * 订单号
 */
@property (nonatomic, copy)NSString *orderId;
/**
 * 用户手机号
 */
@property (nonatomic, copy)NSString *phone;
/**
 * 订单状态  0 未支付 1正常 2已经累积应返金额 3冻结 4取消
 */
@property (nonatomic, copy)NSString *state;
/**
 * 订单金额
 */

@property (nonatomic, copy)NSString *totalAmount;
/*
* 订单时间
*/
@property (nonatomic, copy)NSString *tranTime;


@end

@interface WaitSureOrderCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sortImageview;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *buyCardLabel;

@property (nonatomic, strong)WaitSureOrderModel *dataModel;

@end
