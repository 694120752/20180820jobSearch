//
//  THRPhotoAction.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/19.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRPhotoAction.h"
#import "TZImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface THRPhotoAction() <TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, weak) UIViewController<THRPhotoDelegate> *rootVc;
// 选取的照片张数
@property (nonatomic, assign) NSUInteger photoCount;
// 上一次的选取情况
@property (nonatomic, strong) NSMutableArray *selectedAssets;
// 相机控制器
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation THRPhotoAction
- (instancetype)initWithVc:(UIViewController<THRPhotoDelegate> *)vc andPhotoCount:(NSUInteger)count andLastAsset:(NSArray *)selectedAssets{
    self = [super init];
    _rootVc = vc;
    _photoCount = count;
    _selectedAssets = [selectedAssets mutableCopy];
    return self;
}

- (void)showAlertVc{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoAuthCheck];
    }];
    [alertVc addAction:takePhotoAction];
    
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    [alertVc addAction:imagePickerAction];
   
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    
    [_rootVc presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark ------------- 拍照权限检测
- (void)photoAuthCheck{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self photoAuthCheck];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self photoAuthCheck];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 拍照
- (void)pushImagePickerController{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [_rootVc presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
//        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

// 从相册选
- (void)pushTZImagePickerController{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_photoCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.selectedAssets            = _selectedAssets;
    imagePickerVc.allowTakePicture          = NO;
    imagePickerVc.allowTakeVideo            = NO;
    imagePickerVc.iconThemeColor            = CommonBlue;
    imagePickerVc.cannotSelectLayerColor    = CommonBlue;
    imagePickerVc.allowPickingVideo         = NO;
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
    }];
    
    [_rootVc presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark ------------ 照片结果
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    if (self.rootVc && [self.rootVc respondsToSelector:@selector(pickResult:andAssert:)]) {
        [self.rootVc pickResult:photos andAssert:assets];
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                //NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//                if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
//                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                    }];
//                    imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
//                    imagePicker.circleCropRadius = 100;
//                    [self presentViewController:imagePicker animated:YES completion:nil];
//                } else {
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                }
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    if (self.rootVc && [self.rootVc respondsToSelector:@selector(pickResult:andAssert:)]) {
        [self.rootVc pickResult:@[image] andAssert:_selectedAssets];
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark ----------- lazy
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = _rootVc.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = _rootVc.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}
@end
