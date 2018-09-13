//
//  RegistViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "RegistViewController.h"

#import "VerifyCodeRequest.h"

#import "NSString+zFundation.h"
#import "BaseToast.h"

#import "LoginField.h"
#import "WLCaptcheButton.h"

@interface RegistViewController () <VerCodeProtocol>
//获取验证码
@property (nonatomic, strong) VerifyCodeRequest *verRequest;

// 手机号field
@property (nonatomic, strong) LoginField* phoneTextfield;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setHeaderViewAndTextfield];
   
}

- (void)setHeaderViewAndTextfield{
    
    UIImageView * imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"loginBG"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    imageView.sd_layout
    .topEqualToView(self.view)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .heightIs(PXGet375Width(351));
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = @"注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = font(PXGet375Width(30));
    [imageView addSubview:titleLabel];
    titleLabel.sd_layout
    .topSpaceToView(imageView, PXGet375Width(20) + 20)
    .centerXEqualToView(imageView)
    .rightSpaceToView(imageView, 0)
    .leftSpaceToView(imageView, 0);
    
    // 返回按钮
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(.0f,.0f,44.0f,44.0f)];
    [backButton setImage:[UIImage imageNamed:@"backArrow"]
                forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backArrow"]
                forState:UIControlStateHighlighted];
    backButton.accessibilityLabel = @"返回";
    [imageView addSubview:backButton];
    [backButton addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    backButton.sd_layout.centerYEqualToView(titleLabel);
    
    
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
    _phoneTextfield = phoneTextfield;
    phoneTextfield.placeholder = @"   请输入手机号";
    [phoneTextfield setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    phoneTextfield.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userName"]];
    phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    phoneTextfield.font = font(PXGet375Width(28));
    [self.view addSubview:phoneTextfield];
    
    // 验证码
    LoginField* verTextfield = [[LoginField alloc]init];
    verTextfield.placeholder = @"   请输入验证码";
    [verTextfield setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    verTextfield.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"verCode"]];
    verTextfield.leftViewMode = UITextFieldViewModeAlways;
    verTextfield.font = font(PXGet375Width(28));
    [self.view addSubview:verTextfield];
    // 添加获取验证码按钮
    WLCaptcheButton* getVerButton = [[WLCaptcheButton alloc]init];
    getVerButton.identifyKey = @"regist";
    getVerButton.disabledBackgroundColor = [UIColor lightGrayColor];
    getVerButton.disabledTitleColor = [UIColor whiteColor];
    getVerButton.titleLabel.font = font(20);
    getVerButton.layer.borderColor = CommonBlue.CGColor;
    getVerButton.layer.borderWidth = 1;
    getVerButton.layer.cornerRadius = 5;
    [getVerButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerButton setTitleColor:CommonBlue forState:UIControlStateNormal];
    [getVerButton addTarget:self action:@selector(getVerCode:) forControlEvents:UIControlEventTouchUpInside];
    getVerButton.titleLabel.font = font(PXGet375Width(20));
   
    [verTextfield addSubview:getVerButton];
    getVerButton.sd_layout
    .bottomSpaceToView(verTextfield, 3)
    .topSpaceToView(verTextfield, -3)
    .rightSpaceToView(verTextfield, 0)
    .widthIs(PXGet375Width(120));
    
    
    // 密码
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
    
    verTextfield.sd_layout
    .topSpaceToView(phoneTextfield, PXGet375Width(80))
    .centerXEqualToView(self.view)
    .widthRatioToView(self.view, 0.6)
    .heightIs(PXGet375Width(45));
    
    passTextfield.sd_layout
    .topSpaceToView(verTextfield, PXGet375Width(80))
    .centerXEqualToView(self.view)
    .widthRatioToView(self.view, 0.6)
    .heightIs(PXGet375Width(45));
    
    
    UIButton* regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regButton setTitle:@"注册" forState:UIControlStateNormal];
    [regButton addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    regButton.backgroundColor = RGBACOLOR(64, 146, 255, 1);
    regButton.layer.cornerRadius  = 7;
    regButton.titleLabel.font = font(15);
    [self.view addSubview:regButton];
    
    regButton.sd_layout
    .topSpaceToView(passTextfield, PXGet375Width(90))
    .widthRatioToView(self.view, 0.59)
    .centerXEqualToView(self.view)
    .heightIs(PXGet375Width(75));

}

- (void)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)registAction{
    
}

- (void)getVerCode:(WLCaptcheButton*)button{
    // 搜集信息
    NSString* phoneStr = _phoneTextfield.text;
    
    if (![phoneStr isPhoneNumber]) {
        [BaseToast toast:@"请输入正确的验证码"];
        return;
    }
    
    [button fire];
    
    [self.verRequest getCodeWithSource:VerCodeSourceRregist andPhoneNumber:phoneStr WithResult:^{
        [BaseToast toast:@"验证码发送成功"];
    } andFailedBlock:^{
        [BaseToast toast:@"验证码发送失败"];
    }];
}


#pragma mark ---------------- lazy

- (VerifyCodeRequest *)verRequest{
    if (!_verRequest) {
        _verRequest = [[VerifyCodeRequest alloc]init];
        _verRequest.verDelegate = self;
        
    }
    return _verRequest;
}
@end
