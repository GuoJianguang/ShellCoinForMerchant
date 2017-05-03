//
//  BillDataModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TixianModel.h"



@implementation TixianModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    TixianModel *model = [[TixianModel alloc]init];
    model.userPhone = NullToSpace(dic[@"userPhone"]);
    model.tranTime = NullToNumber(dic[@"tranTime"]);
    model.amount = NullToNumber(dic[@"amount"]);
    model.outDesc = NullToSpace(dic[@"outDesc"]);
    return model;
}

@end
