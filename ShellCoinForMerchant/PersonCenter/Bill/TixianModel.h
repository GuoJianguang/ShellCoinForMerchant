//
//  BillDataModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface TixianModel : BaseModel
/**
 * 提现单号
 */
@property (nonatomic,copy)NSString *userPhone;
/**
 * 提现金额
 */
@property (nonatomic,copy)NSString *tranTime;
/**
 * 提现时间
 */
@property (nonatomic,copy)NSString *amount;

@property (nonatomic,copy)NSString *outDesc;

//0收入，1支出
@property (nonatomic, assign)NSInteger billType;

@end
