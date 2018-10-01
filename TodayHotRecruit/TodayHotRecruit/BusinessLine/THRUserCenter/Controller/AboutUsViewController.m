//
//  AboutUsViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/10/1.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "AboutUsViewController.h"
#import "THRRequestManager.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"关于我们";
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(Get375Width(10), NavigationBar_Bottom_Y, kScreenWidth - Get375Width(10) *2, kScreenHeight - NavigationBar_Bottom_Y);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/config/get"] parameters:@{@"configName":@"system_us"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * resultDic = responseObject;
        label.text = EncodeStringFromDic(resultDic, @"configValue");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
