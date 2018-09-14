//
//  RegistViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "RegistViewController.h"

#import "VerifyCodeRequest.h"
#import "RegistRequest.h"
#import "FindPassRequest.h"

#import "NSString+zFundation.h"
#import "BaseToast.h"

#import "LoginField.h"
#import "WLCaptcheButton.h"

@interface RegistViewController ()
//获取验证码
@property (nonatomic, strong) VerifyCodeRequest *verRequest;

// 注册
@property (nonatomic, strong) RegistRequest *registRequest;

// 手机号field
@property (nonatomic, strong) LoginField* phoneTextfield;

// 密码
@property (nonatomic, strong) LoginField *passTextfield;

// 验证码
@property (nonatomic, strong) LoginField *verTextfield;
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
    _verTextfield = verTextfield;
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
    _passTextfield = passTextfield;
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
    
    
    switch (_vcType) {
        case RegistVc:
        {
            titleLabel.text = @"注册";
            passTextfield.placeholder = @"   请输入密码";
            [regButton setTitle:@"注册" forState:UIControlStateNormal];
        }
            break;
        case FindPassVc:{
            titleLabel.text = @"找回密码";
            passTextfield.placeholder = @"   请输入新密码";
            [regButton setTitle:@"确定" forState:UIControlStateNormal];
        }
            
        default:
            break;
    }

}

- (void)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)registAction{
    
    
    // 搜集数据
    NSString* userName = _phoneTextfield.text;
    NSString* password = _passTextfield.text;
    NSString* sms = _verTextfield.text;
    
    if (IsStrEmpty(userName) || IsStrEmpty(password) || IsStrEmpty(sms)) {
        [BaseToast toast:@"信息不全"];
        return;
    }
    
    switch (_vcType) {
        case RegistVc:
        {
            // 注册动作

            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.label.text = NSLocalizedString(@"正在注册", @"HUD preparing title");
            hud.minSize = CGSizeMake(150.f, 100.f);

            [self.registRequest registWith:userName andPassWord:password andSmsCode:sms WithSuccessBLock:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    hud.customView = imageView;
                    hud.mode = MBProgressHUDModeCustomView;
                    hud.label.text = NSLocalizedString(@"注册成功", @"HUD completed title");
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });

            } andFailedBlock:^(NSString *reason) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = NSLocalizedString(reason, @"HUD completed title");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
            }];

        }
            break;
        case FindPassVc:
        {
            // 找回密码
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.label.text = NSLocalizedString(@"正在修改", @"HUD preparing title");
            hud.minSize = CGSizeMake(150.f, 100.f);
            
            
            FindPassRequest* request = [[FindPassRequest alloc]init];
            [request findPassWithUserName:userName andSmsCode:sms andPassWord:password success:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    hud.customView = imageView;
                    hud.mode = MBProgressHUDModeCustomView;
                    hud.label.text = NSLocalizedString(@"修改成功", @"HUD completed title");
                });
       
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
                
            } failed:^(NSString *reason) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = NSLocalizedString(reason, @"HUD completed title");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
            }];
            
        }

        default:
            break;
    }
}


#pragma mark ------------- 获取验证码
- (void)getVerCode:(WLCaptcheButton*)button{
    // 搜集信息
    NSString* phoneStr = _phoneTextfield.text;
    
    if (![phoneStr isPhoneNumber]) {
        [BaseToast toast:@"请输入正确的验证码"];
        return;
    }
    
    // 有时间做一波本地号码比较
    [button fire];
    
    [self.verRequest getCodeWithSource:_vcType == RegistVc?VerCodeSourceRregist:VerCodeSourceForget andPhoneNumber:phoneStr WithResult:^{
        [BaseToast toast:@"验证码发送成功"];
    } andFailedBlock:^{
        [BaseToast toast:@"验证码发送失败"];
    }];
}


#pragma mark ---------------- lazy

- (VerifyCodeRequest *)verRequest{
    if (!_verRequest) {
        _verRequest = [[VerifyCodeRequest alloc]init];
    }
    return _verRequest;
}

-(RegistRequest *)registRequest{
    if (!_registRequest) {
        _registRequest = [[RegistRequest alloc]init];
    }
    return _registRequest;
}
@end
