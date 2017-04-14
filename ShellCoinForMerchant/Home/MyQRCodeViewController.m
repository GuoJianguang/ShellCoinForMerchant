//
//  MyQRCodeViewController.m
//  ShellCoinForMerchant
//
//  Created by Guo on 2017/4/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "OrderManamentViewController.h"

@interface MyQRCodeViewController ()

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.itemView.layer.cornerRadius = 8;
    self.itemView.layer.masksToBounds = YES;
    [self.sureOrderBtn setTitleColor:MacoColor forState:YES];
    
    [self getQrCodeImage];
    
}


- (void)getQrCodeImage
{
    
    NSInteger width = (TWitdh - 100);
    NSDictionary *parms = @{
                            @"width":@(width),
                            @"height":@(width),
                            @"mchCode":NullToSpace([ShellCoinUserInfo shareUserInfos].code)};
    [SVProgressHUD showWithStatus:@"正在生成二维码" maskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager = [self defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
    NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"qrCode/mch/generate"];
    [manager POST:url parameters:mutalbleParameter success:^(NSURLSessionDataTask *operation, id responseObject) {
        [SVProgressHUD dismiss];
        UIImage *image = [[UIImage alloc]initWithData:responseObject];
        self.qrCodeImageView.image = image;

        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"图形验证码获取失败，请重试" duration:2.];
    }];


}
-(AFHTTPSessionManager*) defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.stringEncoding = RequestSerializerEncoding;
    requestSerializer.timeoutInterval = TimeoutInterval;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.stringEncoding = ResponseSerializerEncoding;
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    
    return manager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goSureOrderBtn:(UIButton *)sender {
    
    OrderManamentViewController *orderManVC = [[OrderManamentViewController alloc]init];
    [self.navigationController pushViewController:orderManVC animated:YES];
}
@end
