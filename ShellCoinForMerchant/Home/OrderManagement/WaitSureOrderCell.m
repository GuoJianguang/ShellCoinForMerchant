//
//  BillConsumptionTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WaitSureOrderCell.h"
#import "BillAmountDataModel.h"
#import "BillDataModel.h"


@implementation WaitSureOrderModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    WaitSureOrderModel *model = [[WaitSureOrderModel alloc]init];
    model.channel = NullToNumber(dic[@"channel"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    model.state = NullToNumber(dic[@"state"]);
    model.phone = NullToNumber(dic[@"userPhone"]);
    model.orderId = NullToNumber(dic[@"orderId"]);
    model.tranTime = NullToNumber(dic[@"tranTime"]);
    return model;
}

@end

@implementation WaitSureOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.markLabel.textColor = MacoTitleColor;
    self.statusLabel.text = @"确认订单";
}

- (void)setDataModel:(WaitSureOrderModel *)dataModel
{
    _dataModel = dataModel;
    self.buyCardLabel.text = @"";
    self.markLabel.text = _dataModel.phone;
    self.timeLabel.text = _dataModel.tranTime;
    self.statusLabel.text = @"确认订单";
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_dataModel.totalAmount];
    
    switch ([_dataModel.channel integerValue]) {
        case 1:
            self.sortImageview.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
            break;
        case 2:
            self.sortImageview.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
            break;
        case 3:
            self.sortImageview.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
            break;
            
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
