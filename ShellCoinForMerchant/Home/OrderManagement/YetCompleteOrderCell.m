//
//  BillConsumptionTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "YetCompleteOrderCell.h"
#import "BillAmountDataModel.h"
#import "BillDataModel.h"

@implementation YetCompleteOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.markLabel.textColor = MacoTitleColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setDataModel:(BillDataModel *)dataModel
{
    _dataModel = dataModel;
//    self.markLabel.text = _xiaofeijiluModel.mchName;
    self.timeLabel.text = _dataModel.tranTime;
    self.buyCardLabel.text = @"";
    NSString *statusStr = [NSString string];
    
    switch ([_dataModel.state integerValue]) {
        case 0:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            statusStr = @"未支付";
        }
        
            break;
            
        case 1:
        {
            statusStr = @"支付成功";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoColor;
        }
            break;
        case 2:
        {
            statusStr = @"支付成功";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoColor;
        }
            break;
        case 3:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            statusStr = @"冻结中";
        }
            break;
        case 4:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            statusStr = @"已取消";
        }
            break;
        default:
            break;
    }
    
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
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_dataModel.totalAmount];
    self.statusLabel.text = statusStr;
}

@end
