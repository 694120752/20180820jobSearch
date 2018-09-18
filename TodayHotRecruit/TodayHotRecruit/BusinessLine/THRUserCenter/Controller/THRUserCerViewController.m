//
//  THRUserCerViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRUserCerViewController.h"


@interface THRUserCerViewController ()

@end

@implementation THRUserCerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNaviTitle];
    [self setUpPhotoButton];
}

- (void)setUpNaviTitle{
    self.view.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"HR认证";
}

- (void)setUpPhotoButton{
    UIButton* mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    mainButton.backgroundColor = RANDOMCOLOR;
    mainButton.layer.cornerRadius = 8;
    [self.view addSubview:mainButton];
    
    mainButton.sd_layout
    .topSpaceToView(self.navBarItemView, PXGet375Width(100))
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(540))
    .heightIs(PXGet375Width(680));
    
    UIButton* subMitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [subMitButton setTitle:@"提交" forState:UIControlStateNormal];
    subMitButton.backgroundColor = CommonBlue;
    subMitButton.titleLabel.font = font(PXGet375Width(30));
    [subMitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    subMitButton.layer.cornerRadius = 8;
    [self.view addSubview:subMitButton];
    subMitButton.sd_layout
    .topSpaceToView(mainButton, PXGet375Width(130))
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(220))
    .heightIs(PXGet375Width(70));
}


@end
