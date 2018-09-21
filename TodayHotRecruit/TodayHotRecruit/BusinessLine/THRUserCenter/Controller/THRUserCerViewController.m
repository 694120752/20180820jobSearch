//
//  THRUserCerViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRUserCerViewController.h"
#import "THRUploadFile.h"
#import "THRRequestManager.h"
#import <MBProgressHUD.h>
#import "THRPhotoAction.h"
#import "UIButton+WebCache.h"

@interface THRUserCerViewController ()<THRPhotoDelegate>
@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, strong) UIButton *mainButton;
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
    _mainButton = mainButton;
    [mainButton setImage:[UIImage imageNamed:@"HRStamp"] forState:UIControlStateNormal];
    mainButton.layer.cornerRadius = 8;
    [mainButton addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchDown];
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
    [subMitButton addTarget:self action:@selector(subMitAction) forControlEvents:UIControlEventTouchUpInside];
    subMitButton.layer.cornerRadius = 8;
    [self.view addSubview:subMitButton];
    subMitButton.sd_layout
    .topSpaceToView(mainButton, PXGet375Width(130))
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(220))
    .heightIs(PXGet375Width(70));
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UserDetail refreshUserDetailWith:^{
        
        NSDictionary* ud = [UserDetail getDetail];
        
        if (!IsStrEmpty(EncodeStringFromDic(ud, @"hrFileUrl"))) {
            [mainButton sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(ud, @"hrFileUrl")] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        }
        
    } andFailedBlock:^(NSString *reason) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
    
}


- (void)subMitAction{
    
    if (NotNilAndNull(self.selectImage)) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [THRUploadFile upLoadFileWithData:@[UIImageJPEGRepresentation(self.selectImage, 0.8)] andTitleArray:nil UploadFailedReason:^(NSString *reasonStr, THRUploadFailedReason reason) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.label.text = @"请重新上传";
                [hud hideAnimated:YES afterDelay:2];
            });
        } UploadProgressBlock:^(float progress) {
            
        } UploadSuccessBlock:^(NSString *filePath) {
            [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/hrAuth"] parameters:@{@"hrFile":filePath} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HudSuccess
                hud.label.text = @"上传成功";
                [hud hideAnimated:YES afterDelay:1];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.label.text = @"请重新上传";
                    [hud hideAnimated:YES afterDelay:2];
                });
            }];
            
        }];
        
    }
}

- (void)selectPhoto{
    THRPhotoAction* action = [[THRPhotoAction alloc]initWithVc:self
                                                 andPhotoCount:1 andLastAsset:nil];
    [action showAlertVc];
}

- (void)pickResult:(NSArray*)photoArray andAssert:(NSArray *)asset{
    if (!IsArrEmpty(photoArray)) {
        self.selectImage = photoArray.firstObject;
        [_mainButton setImage:self.selectImage forState:UIControlStateNormal];
    }
}

@end
