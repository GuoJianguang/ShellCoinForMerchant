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
    model.tixianId = NullToSpace(dic[@"id"]);
    model.withdrawAmout = NullToNumber(dic[@"withdrawAmout"]);
    model.successTime = NullToSpace(dic[@"successTime"]);
    model.state = NullToNumber(dic[@"state"]);
    return model;
}

@end
