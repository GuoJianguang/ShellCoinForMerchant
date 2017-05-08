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
    model.expectSettleAmount = NullToNumber(dic[@"settleAmount"]);
    model.orderId = NullToNumber(dic[@"id"]);
    return model;
}

@end


@implementation StateMentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.totalMoneyLabel.textColor  = self.totalBishuLabel.textColor  = self.shouldJiesuanLabel.textColor = MacoDetailColor;
    self.totalMoney.textColor = self.titalBIshu.textColor = self.shouldJiesuan.textColor =self.time_label.textColor =MacoTitleColor;
    self.gouJiesuanLabel.textColor = MacoColor;
    
    self.totalMoney.adjustsFontSizeToFitWidth = self.titalBIshu.adjustsFontSizeToFitWidth = self.shouldJiesuan.adjustsFontSizeToFitWidth = YES;
    self.status_Btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
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
            [self.status_Btn setTitle:@"未完成" forState:UIControlStateNormal];
            [self.status_Btn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_blue"] forState:UIControlStateNormal];
            self.mark_imageView.hidden = NO;
            self.mark_imageView.image = [UIImage imageNamed:@"pic_statements_blue"];
            self.successMarkImageView.hidden = YES;
            
            
//            self.successMarkImageView.image = [UIImage imageNamed:@"pic_statements_blue"];
//            self.mark_imageView.hidden = YES;
//            self.successMarkImageView.hidden = NO;
//            self.goJiesuanHeight.constant = 38;
//            self.gouJiesuanView.hidden = NO;
        }
            break;
        case 1:
        {
            [self.status_Btn setTitle:@"已完成" forState:UIControlStateNormal];
            [self.status_Btn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_red"] forState:UIControlStateNormal];
            self.successMarkImageView.image = [UIImage imageNamed:@"pic_statements_red"];
            self.mark_imageView.hidden = YES;
            self.successMarkImageView.hidden = NO;
            self.goJiesuanHeight.constant = 0;
            self.gouJiesuanView.hidden = YES;
        }
            break;
        case 2:
        {
            [self.status_Btn setTitle:@"结算失败" forState:UIControlStateNormal];
            [self.status_Btn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_green"] forState:UIControlStateNormal];
            self.mark_imageView.hidden = NO;
            self.mark_imageView.image = [UIImage imageNamed:@"pic_statements_green"];
            self.successMarkImageView.hidden = YES;
            
            
//            self.successMarkImageView.image = [UIImage imageNamed:@"pic_statements_green"];
//            self.mark_imageView.hidden = YES;
//            self.successMarkImageView.hidden = NO;
//            self.goJiesuanHeight.constant = 38;
//            self.gouJiesuanView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

@end
