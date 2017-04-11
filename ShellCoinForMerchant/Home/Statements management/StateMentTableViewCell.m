//
//  StateMentTableViewCell.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/7.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "StateMentTableViewCell.h"

@implementation StateMentDataModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    StateMentDataModel *model = [[StateMentDataModel alloc]init];
    model.state = NullToNumber(dic[@"state"]);
    model.time = NullToNumber(dic[@"time"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    model.totalCount = NullToNumber(dic[@"totalCount"]);
    model.waitSettleAmount = NullToNumber(dic[@"waitSettleAmount"]);
    model.expectSettleAmount = NullToNumber(dic[@"expectSettleAmount"]);
    model.orderId = NullToNumber(dic[@"id"]);
    return model;
}

@end


@implementation StateMentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(StateMentDataModel *)dataModel
{
    _dataModel = dataModel;
    self.time_label.text = _dataModel.time;
    
    self.totalMoney.text = [NSString stringWithFormat:@"¥%@",_dataModel.totalAmount];
    self.titalBIshu.text = _dataModel.totalCount;
    self.shouldJiesuan.text = [NSString stringWithFormat:@"¥%@",_dataModel.expectSettleAmount];
    switch ([_dataModel.state integerValue]) {
        case 0:
        {
            self.status_label.text = @"未完成";
            self.mark_imageView.hidden = NO;
            self.successMarkImageView.hidden = YES;
        }
            break;
        case 1:
        {
            self.status_label.text = @"已完成";
            self.mark_imageView.hidden = YES;
            self.successMarkImageView.hidden = NO;
            self.goJiesuanHeight.constant = 0;
            self.gouJiesuanView.hidden = YES;
        }
            break;
        case 2:
        {
            self.status_label.text = @"结算失败";
            self.mark_imageView.hidden = NO;
            self.successMarkImageView.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end
