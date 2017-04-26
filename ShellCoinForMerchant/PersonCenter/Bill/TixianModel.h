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
 * 抵换单号
 */
@property (nonatomic,copy)NSString *tixianId;
/**
 * 抵换金额
 */
@property (nonatomic,copy)NSString *withdrawAmout;
/**
 * 抵换时间
 */
@property (nonatomic,copy)NSString *successTime;
/**
 * 抵换状态 0待审核  1审核通过  2抵换中   3抵换成功  4抵换失败
 */
@property (nonatomic,copy)NSString *state;


@end
