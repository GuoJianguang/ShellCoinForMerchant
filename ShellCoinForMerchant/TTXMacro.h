//
//  TTXMacro.h
//  天添薪
//
//  Created by ttx on 16/1/6.
//  Copyright © 2016年 ttx. All rights reserved.
//

#ifndef TTXMacro_h
#define TTXMacro_h



#define NullToSpace(string) (([string class] != [NSNull class] && string) ? [string description]: @"")
#define NullToNumber(string) (([string class] != [NSNull class] && string) ? [string description]: @"0")

//友盟的key
/**
 友盟appstore的key
 */
#define YoumengKey @"58eb4a2a9f06fd4da30016f2"
/**
 友盟企业版的key
 */
#define YoumengKey_Inhouse @"56a9b2dae0f55ae6190022b1"

//#define PasswordKey @"SV245HYJH"
#define PasswordKey @"PW2017$LY"

//高德地图的key
/**
 高德appstore的key
 */
#define MAP_APPKEY_APPSTORE @"7b72796b9d236aadd3abb799effad1f6"
/**
 高德企业版的key
 */
#define MaP_AppKey_INHOuse  @"88156c91f812f4686e57064646006224"


//加载失败的图片
#define LoadingErrorImage ([UIImage imageNamed:@"loading_error"])
#define BannerLoadingErrorImage ([UIImage imageNamed:@"banner_loading_error"])
#define HeaderLoadingErrorImage ([UIImage imageNamed:@"user_defalut_icon"])
#define AppIconImage ([UIImage imageNamed:@"appDefaltIcon"])



//登出的通知
#define LogOutNSNotification @"LogOutNSNotification"
//记录历史的城市选择
#define CommonlyUsedCity @"CommonlyUsedCity"
//修改头像成功
#define ChangeHeadImageSuccess @"ChangeHeadImageSuccess"
//修改昵称成功
#define ChangeNickNameSucces @"ChangeNickNameSucces"
//保存登录的用户名
#define LoginUserName @"LoginUserName"
#define LoginUserPassword @"LoginUserPassword"
//是否第一次启动
#define IsFirstLaunch @"isFirstLaunch"
//保存本用户的的商户号
#define MyBussinssCode @"MyBussinssCode"


//微信支付的结果回调
#define WeixinPayResult @"WeixinPayResult"

//支付宝支付结果回掉
#define AliPayResult @"AliPayResult"
//接收推送
#define Upush_Notifi @"Upush_Fanxian_Notifi"




#define AutoLoginAfterGetDeviceToken @"AutoLoginAfterGetDeviceToken"

#define IsRequestTrue ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"0"])

#define TWitdh  [UIScreen mainScreen].bounds.size.width
#define THeight [UIScreen mainScreen].bounds.size.height
#define MacoColor [UIColor colorFromHexString:@"#ea3d3a"]
#define MacoPriceColor [UIColor colorFromHexString:@"f27242"]
#define MacoGrayColor [UIColor colorWithRed:237/255. green:238/255. blue:234/255. alpha:1]

//标题的颜色
#define MacoTitleColor [UIColor colorFromHexString:@"#424242"]
//详情的字体颜色
#define MacoDetailColor [UIColor colorFromHexString:@"#969696"]

//介绍的字体颜色
#define MacoIntrodouceColor [UIColor colorFromHexString:@"#b4b4b4"]
//边框的颜色
#define MacolayerColor [UIColor colorFromHexString:@"#e6e6e6"]

//分页请求的每页的数据
#define MacoPageSize @"20"


//appStore地址
#define AppStoreDetailUrl @"https://itunes.apple.com/us/app/tian-tian-xin-shang-jia-ban/id1095617211?l=zh&ls=1&mt=8"

#endif /* TTXMacro_h */
