//
//  THRSettingViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/18.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRSettingViewController.h"
#import "LoginViewController.h"

@interface THRSettingViewController ()

@end

@implementation THRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self setLogOut];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"设置";
}

- (void)setLogOut{
    UIButton* logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutBtn.backgroundColor = CommonBlue;
    logOutBtn.layer.cornerRadius = 8;
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];
    
    logOutBtn.sd_layout
    .topSpaceToView(self.view, PXGet375Width(80 + 400) + NavigationBar_Bottom_Y)
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(260))
    .heightIs(PXGet375Width(80));
}

- (void)logOutAction{
    
    UserDefault
    [ud setValue:@"NO" forKey:@"isLogin"];
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];

}

@end
