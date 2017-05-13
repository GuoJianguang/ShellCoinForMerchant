//
//  WeXinPayObject.m
//  tiantianxin
//
//  Created by ttx on 16/4/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "WeXinPayObject.h"

static WeXinPayObject *instance;
static NSString *appid = @"2017050807159925";
static NSString *rsaPrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCElEVxJmmY0G3NHuzFiLUWVpDu5jDzoUT6oMnq41frxzvHJQ+yp7RBWBPCo8gEtT4842yrudUucDx5yTdiGpwi3EQ2QEwjzTIqi2PAmhlEG7zooErbIRVYFfnKTVlXQ74A0nTMT+sq4UTyTlt3m06Ioxma2PZ69i+QJRVjqc/9us+kx+GTusQZeV1IeHqmvNEn+6dOHeiZ77NAjXW+WKDYV20qSX/zE6jKSwKnmqOlOOMx+t3K9ZHzNIVycwRoaftYOenn4s8fk8hrVQxhgWAQSpTeBBNFauGNuPov27+cqi/ymdMGUGGhphbfofr4Aopc0r+YOVR07sjgzjpJk+2PAgMBAAECggEANAEhGBg0NaAUYfBuebF9Luz33u3mZ7prn0/wxDU3KKI2/Y+5D6Ae4b7VyXSLIeWiKyoeV2IGkDewUSkvk0jS1A3Ip+sisqxrsCqLD2Ki5Ido22r80eWxRKMiH0ul7sgAwLvM2tPCcEh6zf0Ufd8quAgaJBZU4LiuwYD6WeSjVGgd0BbA4nLs4u7M1piXm12qzdnjunJyxvqqFY9wL+5L15tU5py/CaOeZNpJmAMsAqadYRsaOcy9YhnnW8bkKabqpomjoYp47mkHRNIk21W+g7fz+QFHzlK38pWQ+PJmnAKbBXREFKZhkkEpkTJBFeLGeV+xDbGrlTJDTPoJBx13cQKBgQDlD/TfzMZ5nGM92XArgjsCB57U3c494rByuG1A/ptWMiBZLv0JjzSuocI8q51s3OwhYMFM0AwadRX9opt6CvOtiqXpeZTWQQ7S7JuT+jxVCfk4KyeOQ7HCIgzuk4jXWVg9OERN59f19MfwLRY1RmduOw0i/L/qiZ89hTEwkYh/uQKBgQCUK6Ni4RjOFHybUmrx4gCWZfmFcnhsnHHXClinE9K5atJYEU9p43YOLhB4w5tsKT0IU0vgYRXUWymZgtdfLh6Ej0QDqmHndAPSacSY19Az8vGx7s7toiW54ciCxHjpsWDBhd7XN3syYN47i/WEdwrFA7nRGBYQ886HVRFDG4irhwKBgQDigsfss4uk4HAGzkkszSha1nxLFVeIPO2tVBC9z8h+ES2J43xXgqRe+BiidDZFW6WpUAt2UNlXJGdtm+nRYpkbCFsOqKr0v/rPuygRycb1dNpcn9gKx4g1aASPu5b7FR+70jNBMr2NO9Sm/X7Tid5n078m1PdXD2ZHqLk+xPtNCQKBgH24VSaV5c0d1uiXUsSvxV3XYpNXIFTPnUwfrD7/c+H9gEJXVbF73XSEo1dEaYCpsO56drwIxFPtket9+C37XMuPH9+YVv/jEUcclUI2g6NAdNFL1moNFcOVjuNdv1ZSOc2aQA0ON0r0pDuUMprVwt6NncGLlVWG+OsdQ8tT9m/LAoGBALgqy4D9Hn1MR13royI186ztWOOcR6TV+ambPFN5gLnod5zoqHCEI1lkeEUZvzp1D/NfEg5v5wXXAAXiN0ReNcpAqXjqoxUwzG2L6VNboadrGQ9TxPaIoTEB9tgIlBvExQJ7zg9FEMySXv+W8qyRYuKvtdx3LmYXK4CwS4TdKyno";

@interface WeXinPayObject()

@end

@implementation WeXinPayObject


+ (WeXinPayObject *)shareWexinPayObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WeXinPayObject alloc]init];
    });
    return instance;
}

+ (void)startWexinPay:(NSDictionary *)parms
{
    [SVProgressHUD showWithStatus:@"正在发送支付请求" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient GET:@"pay/mch/settle/wxpay" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            NSDictionary *dict = jsonObject[@"data"];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req] ;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"订单生成失败,请稍后重试" duration:2.];
    }];
}


- (void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response= (PayResp*)resp;
        NSDictionary *dic = @{@"resultcode":[NSString stringWithFormat:@"%d",response.errCode]};
        [[NSNotificationCenter defaultCenter]postNotificationName:WeixinPayResult object:nil userInfo:dic];

        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}

@end
