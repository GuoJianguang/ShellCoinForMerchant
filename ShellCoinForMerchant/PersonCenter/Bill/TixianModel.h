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


@interface TixianRecodModel : BaseModel
@property (nonatomic, copy)NSString *withdrawAmout;
@property (nonatomic, copy)NSString *successTime;
//state 提现状态 0待审核  1审核通过  2提现中   3提现成功  4提现失败 
@property (nonatomic, copy)NSString *state;

@end

