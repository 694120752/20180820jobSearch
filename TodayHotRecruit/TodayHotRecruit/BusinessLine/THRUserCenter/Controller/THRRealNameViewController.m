//
//  RealNameViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRRealNameViewController.h"

@interface THRRealNameViewController ()

@end

@implementation THRRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpNavi];
    
    [self setUpLoadButton];
}

- (void)SetUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"实名认证";
}

- (void)setUpLoadButton{
    UIButton* frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    frontButton.backgroundColor = RANDOMCOLOR;
    frontButton.layer.cornerRadius = 8;
    [self.view addSubview:frontButton];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.layer.cornerRadius = 8;
    backBtn.backgroundColor = RANDOMCOLOR;
    [self.view addSubview:backBtn];
    
    UIButton* submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 8;
    [submitButton setTitle:@"确认上传" forState:UIControlStateNormal];
    submitButton.backgroundColor = CommonBlue;
    submitButton.titleLabel.font = font(PXGet375Width(30));
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    frontButton.sd_layout
    .topSpaceToView(self.navBar, PXGet375Width(100))
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(510))
    .heightIs(PXGet375Width(300));
    
    backBtn.sd_layout
    .topSpaceToView(frontButton, PXGet375Width(56))
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(510))
    .heightIs(PXGet375Width(300));
    
    
    submitButton.sd_layout
    .topSpaceToView(backBtn, PXGet375Width(127))
    .widthIs(PXGet375Width(250))
    .heightIs(PXGet375Width(70))
    .centerXEqualToView(self.view);
    
}

@end
