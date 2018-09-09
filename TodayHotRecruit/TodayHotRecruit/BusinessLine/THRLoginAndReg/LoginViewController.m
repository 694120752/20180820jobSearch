//
//  LoginViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginField.h"
#import "RegistViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setHeaderViewAndTextfield];
}

- (void)setHeaderViewAndTextfield{
    
    UIImageView * imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"loginBG"];
    [self.view addSubview:imageView];
    imageView.sd_layout
    .topEqualToView(self.view)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .heightIs(PXGet375Width(351));
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = font(PXGet375Width(30));
    [imageView addSubview:titleLabel];
    titleLabel.sd_layout
    .topSpaceToView(imageView, PXGet375Width(20) + 20)
    .centerXEqualToView(imageView)
    .rightSpaceToView(imageView, 0)
    .leftSpaceToView(imageView, 0);
    
    UIImageView* headerImage = [UIImageView new];
    headerImage.image = [UIImage imageNamed:@"noHead"];
    headerImage.layer.cornerRadius = PXGet375Width(150) / 2;
    headerImage.clipsToBounds = YES;
    [imageView addSubview:headerImage];
    headerImage.sd_layout
    .widthIs(PXGet375Width(150))
    .heightIs(PXGet375Width(150))
    .centerXEqualToView(imageView)
    .bottomSpaceToView(imageView, PXGet375Width(45));
    
    // 输入手机号
    LoginField *phoneTextfield = [[LoginField alloc]init];
    phoneTextfield.placeholder = @"   请输入手机号";
    [phoneTextfield setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    phoneTextfield.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userName"]];
    phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    phoneTextfield.font = font(PXGet375Width(28));
    [self.view addSubview:phoneTextfield];
    
    // 输入密码
    LoginField* passTextfield = [[LoginField alloc]init];
    passTextfield.placeholder = @"   请输入密码";
    [passTextfield setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    passTextfield.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"passWord"]];
    passTextfield.leftViewMode = UITextFieldViewModeAlways;
    passTextfield.font = font(PXGet375Width(28));
    [self.view addSubview:passTextfield];
    
    phoneTextfield.sd_layout
    .topSpaceToView(imageView, PXGet375Width(100))
    .centerXEqualToView(self.view)
    .widthRatioToView(self.view, 0.6)
    .heightIs(PXGet375Width(45));
    
    passTextfield.sd_layout
    .topSpaceToView(phoneTextfield, PXGet375Width(80))
    .centerXEqualToView(self.view)
    .widthRatioToView(self.view, 0.6)
    .heightIs(PXGet375Width(45));
    
    // 前往注册
    UIButton* goReg = [UIButton buttonWithType:UIButtonTypeCustom];
    goReg.titleLabel.sd_layout.leftSpaceToView(goReg, 0);
    [goReg setTitle:@"前往注册" forState:UIControlStateNormal];
    [goReg setTitleColor:RGBACOLOR(139, 139, 139, 1) forState:UIControlStateNormal];
    goReg.titleLabel.font = font(13);
    [goReg addTarget:self action:@selector(goOpenRegistVc) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:goReg];
    
    goReg.sd_layout
    .leftEqualToView(passTextfield)
    .heightIs(PXGet375Width(80))
    .topSpaceToView(passTextfield, PXGet375Width(10))
    .widthRatioToView(self.view, 0.2);
    
    // 忘记密码
    UIButton* forGetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    forGetPass.titleLabel.sd_layout.rightSpaceToView(forGetPass, 0);
    [forGetPass setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forGetPass setTitleColor:RGBACOLOR(139, 139, 139, 1) forState:UIControlStateNormal];
    forGetPass.titleLabel.font = font(13);
    [self.view addSubview:forGetPass];
    
    forGetPass.sd_layout
    .topSpaceToView(passTextfield, PXGet375Width(10))
    .heightIs(PXGet375Width(80))
    .rightEqualToView(passTextfield)
    .widthRatioToView(self.view, 0.2);
    
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = RGBACOLOR(64, 146, 255, 1);
    loginButton.layer.cornerRadius  = 7;
    loginButton.titleLabel.font = font(15);
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    loginButton.sd_layout
    .topSpaceToView(goReg, PXGet375Width(60))
    .widthRatioToView(self.view, 0.59)
    .centerXEqualToView(self.view)
    .heightIs(PXGet375Width(75));
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)goOpenRegistVc{
    // 正确的返回姿势
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
    
}


- (void)loginAction{
    
    UserDefault
    [ud setValue:@"YES" forKey:@"isLogin"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
