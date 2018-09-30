//
//  MyfundsViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "MyfundsViewController.h"

@interface MyfundsViewController ()

@end

@implementation MyfundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

- (void)setupNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"我的资金";
}


@end
