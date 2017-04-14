//
//  StateMentTableViewCell.h
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StateMentDataModel : BaseModel
/**
 * 结算单号
 */
@property (nonatomic, copy)NSString *orderId;
/**
 * 应结算金额
 */

@property (nonatomic, copy)NSString *expectSettleAmount;
/**
 * 未结算金额
*/
@property (nonatomic, copy)NSString *waitSettleAmount;
/**
 * 总笔数
 */

@property (nonatomic, copy)NSString *totalCount;
/**
 * 总营业额
 */

@property (nonatomic, copy)NSString *totalAmount;
/**
 * 时间
 */

@property (nonatomic, copy)NSString *time;
/**
 * 状态 0未扣款 1成功 2扣款失败
 */

@property (nonatomic, copy)NSString *state;


@end

@interface StateMentTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *time_label;

@property (weak, nonatomic) IBOutlet UILabel *status_label;

@property (weak, nonatomic) IBOutlet UIImageView *mark_imageView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalBishuLabel;
@property (weak, nonatomic) IBOutlet UILabel *titalBIshu;
@property (weak, nonatomic) IBOutlet UILabel *shouldJiesuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouldJiesuan;
@property (weak, nonatomic) IBOutlet UILabel *gouJiesuanLabel;

@property (nonatomic, strong)StateMentDataModel *dataModel;
@property (weak, nonatomic) IBOutlet UIImageView *successMarkImageView;
@property (weak, nonatomic) IBOutlet UIView *gouJiesuanView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goJiesuanHeight;

@property (weak, nonatomic) IBOutlet UIButton *status_Btn;

@end
