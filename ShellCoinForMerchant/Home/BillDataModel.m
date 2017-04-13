//
//  BillDataModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillDataModel.h"

@implementation BillDataModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BillDataModel *model = [[BillDataModel alloc]init];
    model.channel = NullToNumber(dic[@"channel"]);
    model.totalAmount = NullToNumber(dic[@"totalAmount"]);
    model.state = NullToNumber(dic[@"state"]);
    model.phone = NullToNumber(dic[@"userPhone"]);
    model.orderId = NullToNumber(dic[@"orderId"]);
    model.tranTime = NullToNumber(dic[@"tranTime"]);
    return model;
}


@end


