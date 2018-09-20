//
//  RealNameViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRRealNameViewController.h"
#import "THRPhotoAction.h"
#import "BaseToast.h"
#import <MBProgressHUD.h>
#import "THRUploadFile.h"
#import "THRRequestManager.h"
#import "UIButton+WebCache.h"

@interface THRRealNameViewController ()<THRPhotoDelegate>
@property (nonatomic, strong) UIButton *currentButton;

// 正面图片
@property (nonatomic, strong) UIImage *frontImage;
// 反面图片
@property (nonatomic, strong) UIImage *backImage;

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
    frontButton.tag = 1001;
    frontButton.layer.cornerRadius = 8;
    [frontButton addTarget:self action:@selector(takePhotoWithButton:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:frontButton];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.layer.cornerRadius = 8;
    backBtn.tag = 1002;
    [backBtn addTarget:self action:@selector(takePhotoWithButton:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
    
    UIButton* submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 8;
    [submitButton setTitle:@"确认上传" forState:UIControlStateNormal];
    submitButton.backgroundColor = CommonBlue;
    submitButton.titleLabel.font = font(PXGet375Width(30));
    [submitButton addTarget:self action:@selector(sureUpLoad) forControlEvents:UIControlEventTouchUpInside];
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

    [frontButton setImage:[UIImage imageNamed:@"IDCard_f"] forState:UIControlStateNormal];

    [backBtn setImage:[UIImage imageNamed:@"IDCard_b"] forState:UIControlStateNormal];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在获取上一次的数据";
    [UserDetail refreshUserDetailWith:^{
        
        NSDictionary* dic = [UserDetail getDetail];
        dispatch_group_t idGroup = dispatch_group_create();
        
        dispatch_group_enter(idGroup);
        if (!IsStrEmpty(EncodeStringFromDic(dic, @"idCardAUrl"))) {
            [frontButton sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(dic, @"idCardAUrl")] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                dispatch_group_leave(idGroup);
            }];
        }else{
            dispatch_group_leave(idGroup);
        }
        
        dispatch_group_enter(idGroup);
        if (!IsStrEmpty(EncodeStringFromDic(dic, @"idCardBUrl"))) {
            [backBtn sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(dic, @"idCardBUrl")] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                dispatch_group_leave(idGroup);
            }];
        }else{
            dispatch_group_leave(idGroup);
        }
        
        dispatch_group_notify(idGroup, dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        
    } andFailedBlock:^(NSString *reason) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络不畅";
        [hud hideAnimated:YES afterDelay:1];
    }];
    
 
}

- (void)takePhotoWithButton:(UIButton *)button{
    THRPhotoAction * action = [[THRPhotoAction alloc]initWithVc:self andPhotoCount:1 andLastAsset:nil];
    [action showAlertVc];
    self.currentButton = button;
}

- (void)pickResult:(NSArray*)photoArray andAssert:(NSArray *)asset{
    if (!IsArrEmpty(photoArray)) {
        UIImage *selectImage = photoArray.firstObject;
        [self.currentButton setImage:selectImage forState:UIControlStateNormal];
        if (self.currentButton.tag == 1001) {
            // 正
            self.frontImage = selectImage;
        }else{
            // 反
            self.backImage = selectImage;
        }
    }
}

- (void)sureUpLoad{
    if (NotNilAndNull(self.frontImage) && NotNilAndNull(self.backImage)) {
        
        dispatch_group_t idCardGroup = dispatch_group_create();

        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"正在上传 请等待 ...";
        NSMutableDictionary* urlDic = [NSMutableDictionary dictionary];
        __block NSUInteger successCount = 0;
        dispatch_group_enter(idCardGroup);
        [THRUploadFile upLoadFileWithData:@[UIImageJPEGRepresentation(self.frontImage, 0.8)] andTitleArray:nil UploadFailedReason:^(NSString *reasonStr, THRUploadFailedReason reason) {
            dispatch_group_leave(idCardGroup);
        } UploadProgressBlock:^(float progress) {
        } UploadSuccessBlock:^(NSString *filePath) {
            successCount ++;
            [urlDic setValue:filePath forKey:@"idCardA"];
            dispatch_group_leave(idCardGroup);
        }];
        
        dispatch_group_enter(idCardGroup);
        [THRUploadFile upLoadFileWithData:@[UIImageJPEGRepresentation(self.backImage,0.8)] andTitleArray:nil UploadFailedReason:^(NSString *reasonStr, THRUploadFailedReason reason) {
            dispatch_group_leave(idCardGroup);
        } UploadProgressBlock:^(float progress) {
        } UploadSuccessBlock:^(NSString *filePath) {
            successCount ++;
            [urlDic setValue:filePath forKey:@"idCardB"];
            dispatch_group_leave(idCardGroup);
        }];
        
        dispatch_group_notify(idCardGroup, dispatch_get_global_queue(0, 0), ^{
           // 去提交
            if (successCount == 2) {
                
                [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/realAuth"] parameters:urlDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    DESC
                    if ([desc isEqualToString:@"success"]) {
                        [UserDetail refreshUserDetail];
                        MBSuccess
                        hud.label.text = @"上传成功";
                        [hud hideAnimated:YES afterDelay:1];
                    }else{
                        hud.mode =MBProgressHUDModeText;
                        hud.label.text = desc;
                        [hud hideAnimated:YES afterDelay:2];
                    }
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    hud.mode =MBProgressHUDModeText;
                    hud.label.text = @"请重新上传！";
                    [hud hideAnimated:YES afterDelay:1];
                }];
                
            }else{
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"请重新上传！";
                [hud hideAnimated:YES afterDelay:1];
            }
        });
        
    }else{
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请上传正反两张";
        [hud hideAnimated:YES afterDelay:1];
    }
}

@end
