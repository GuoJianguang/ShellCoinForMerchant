//
//  AliPayObject.h
//  ShellCoinForMerchant
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliPayObject : NSObject
+ (AliPayObject *)shareAliPayObject;
//结算发起调起支付宝支付的请求
+ (void)startAliPayMerchantJiesuan:(NSDictionary *)parms;
@end
