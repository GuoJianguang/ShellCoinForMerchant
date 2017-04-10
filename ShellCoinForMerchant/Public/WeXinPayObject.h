//
//  WeXinPayObject.h
//  tiantianxin
//
//  Created by ttx on 16/4/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface WeXinPayObject : NSObject<WXApiDelegate>

+ (WeXinPayObject *)shareWexinPayObject;

//结算发起的微信支付
+ (void)startWexinPay:(NSDictionary *)parms;



@end
