//
//  THRUserInfoViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRUserInfoViewController.h"
#import "BaseTableView.h"

// tableViewCell
#import "UserInfoHeadImageTableViewCell.h"
#import "UserInfoBaseTableViewCell.h"

// 工具
#import "THRPhotoAction.h"
#import "THRUploadFile.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
#import <BRDatePickerView.h>
#import <BRAddressPickerView.h>
#import <BRStringPickerView.h>


@interface THRUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,THRPhotoDelegate>
/** 主体tableVIew*/
@property(nonatomic,strong)BaseTableView* tableView;

// 照片的assert
@property (nonatomic, strong) NSArray *imageAssert;

@end

typedef enum : NSUInteger {
    HeaderImage,
    NickName,
    Gender,
    PhoneNumber,
    BirthDay,
    City,
    HomeLand,
    AcademicBackground
} UserInfoCell;

@implementation THRUserInfoViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavi];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:UserCenterRefresh object:nil];
}

-(void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"个人信息";
}

- (void)refreshAction{
    [self.tableView reloadData];
}

#pragma mark ---- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return AcademicBackground + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case HeaderImage:
        {
            UserInfoHeadImageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoHeadImageTableViewCell class])];
            [cell upDateData];
            return cell;
        }
            break;
        case NickName:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"nickName";
            return cell;
        }
            break;
        case Gender:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"sex";
            return cell;
        }
            break;
        case PhoneNumber:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"phone";
            return cell;
        }
            break;
        case BirthDay:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"birthday";
            return cell;
        }
            break;
        case City:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"cityName";
            return cell;
        }
            break;
        case HomeLand:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"birthCityName";
            return cell;
        }
        case AcademicBackground:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            cell.labelCase = @"education";
            return cell;
        }
        default:
        {
            UserInfoBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
            return cell;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case HeaderImage:
            return PXGet375Width(140);
            break;
            
        default:
            return PXGet375Width(100);
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case HeaderImage:
        {
            // 上传头像
            THRPhotoAction* photo = [[THRPhotoAction alloc]initWithVc:self andPhotoCount:1 andLastAsset:self.imageAssert];
            [photo showAlertVc];
        }
            break;
        case NickName:
        {
            // 修改用户名
            [self changeNickName];
        }
            break;
        case Gender:
        {
            [self changeGender];
        }
          break;
        case PhoneNumber:
        {
            [self changePhoneNumber];
        }
            break;
        case BirthDay:
        {
            [self changeBirthDay];
        }
             break;
        case City:
        {
            [self addressChangeWithParameterFirst:@"province" ParameterSecond:@"city"];
        }
             break;
        case HomeLand:{
            [self addressChangeWithParameterFirst:@"birthProvince" ParameterSecond:@"birthCity"];
        }
             break;
        case AcademicBackground:{
            [self selectAcademicBackground];
        }
             break;
        default:
            break;
    }
}

#pragma mark ---- THRPhotoDelegate  -- 修改头像
-(void)pickResult:(NSArray *)photoArray andAssert:(NSArray *)asset{
    self.imageAssert = asset;
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
    if (!IsArrEmpty(photoArray)) {
        UIImage* photo = photoArray.firstObject;
        NSData* photoData = UIImageJPEGRepresentation(photo, 0.8);
        [THRUploadFile upLoadFileWithData:@[photoData] andTitleArray:nil UploadFailedReason:^(NSString *reasonStr, THRUploadFailedReason reason) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.mode = MBProgressHUDModeText;
                hud.label.text = NSLocalizedString(reasonStr, @"图像上传出现问题！");
                [hud hideAnimated:YES afterDelay:1];
            });
        } UploadProgressBlock:^(float progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = progress;
            });
        } UploadSuccessBlock:^(NSString *filePath) {

            [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"portrait":filePath} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DESC
                if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
                    [UserDetail refreshUserDetailWith:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                            hud.customView = imageView;
                            hud.mode = MBProgressHUDModeCustomView;
                            hud.label.text = NSLocalizedString(@"上传成功", @"HUD completed title");
                            [hud hideAnimated:YES afterDelay:1];
                        });
                    } andFailedBlock:^(NSString *reason) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text = NSLocalizedString(reason, @"图像上传出现问题！");
                            [hud hideAnimated:YES afterDelay:1];
                        });
                    }];
                }else{
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = NSLocalizedString(@"网络不畅", @"图像上传出现问题！");
                    [hud hideAnimated:YES afterDelay:1];
                });
            }];
            
        }];
        
    }
}

#pragma mark ---- 修改昵称
- (void)changeNickName{
    UIAlertController* nickName = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [nickName addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = EncodeStringFromDic([UserDetail getDetail], @"nickName");
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* nameStr = nickName.textFields.lastObject.text;
        if (!IsStrEmpty(nameStr)) {
            [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"nickName":nameStr} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DESC
                [UserDetail refreshUserDetail];
                if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
                    [UserDetail refreshUserDetail];
                    [BaseToast toast:@"修改成功"];
                }else{
                    [BaseToast toast:desc];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [BaseToast toast:@"网络不畅"];
            }];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [nickName addAction:action1];
    [nickName addAction:action2];
    
    [self presentViewController:nickName animated:YES completion:nil];
}

// 修改性别
#pragma mark ---- 修改性别
- (void)changeGender{
    UIAlertController* genderAction = [UIAlertController alertControllerWithTitle:@"修改性别" message:@"是男是女？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeGenderActionWith:YES];
    }];
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeGenderActionWith:NO];
    }];
    
    [genderAction addAction:male];
    [genderAction addAction:female];
    
    [self presentViewController:genderAction animated:YES completion:nil];
    
}

- (void)changeGenderActionWith:(BOOL)gender{
    
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"sex":gender?@"1":@"2"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        [UserDetail refreshUserDetail];
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            [BaseToast toast:@"修改成功"];
        }else{
            [BaseToast toast:desc];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"网络不畅"];
    }];
    
}


#pragma mark ---- 修改手机号码
- (void)changePhoneNumber{
     UIAlertController* phoneAlert = [UIAlertController alertControllerWithTitle:@"修改手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [phoneAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = EncodeStringFromDic([UserDetail getDetail], @"userName");
    }];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* phone = phoneAlert.textFields.lastObject.text;
        if ([phone isPhoneNumber]) {
            [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"phone":phone} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DESC
                if ([desc isEqualToString:@"success"]) {
                    [UserDetail refreshUserDetail];
                    [BaseToast toast:@"修改成功"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [BaseToast toast:@"网络不畅"];
            }];
        }else{
            [BaseToast toast:@"请输入正确号码"];
        }
        
    }];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [phoneAlert addAction:action];
    [phoneAlert addAction:action2];
    
    [self presentViewController:phoneAlert animated:YES completion:nil];
}

#pragma mark ---- 修改生日
- (void)changeBirthDay{
    [BRDatePickerView showDatePickerWithTitle:@"选择生日" dateType:BRDatePickerModeDate defaultSelValue:EncodeStringFromDic([UserDetail getDetail], @"birthday") resultBlock:^(NSString *selectValue) {
        [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"birthday":selectValue} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DESC
            if ([desc isEqualToString:@"success"]) {
                [UserDetail refreshUserDetail];
                [BaseToast toast:@"修改成功"];
            }else{
                [BaseToast toast:desc];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [BaseToast toast:@"网络不畅"];
        }];
    }];
}

#pragma mark ---- 修改所在城市 && 家乡

- (void)addressChangeWithParameterFirst:(NSString *)first ParameterSecond:(NSString *)second{
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeCity defaultSelected:nil isAutoSelect:NO themeColor:CommonBlue resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        // 先查询
        [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/address/list"] parameters:@{@"name":city.name,@"level":@"2"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary* resultDic = responseObject;
            NSArray* dataArray = EncodeArrayFromDic(resultDic, @"dataList");
            
            if (IsArrEmpty(dataArray)) {
                [BaseToast toast:@"地址查询失败"];
            }else{
                // 修改动作
                NSDictionary *adressDic = dataArray.firstObject;
               
                [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{first:EncodeStringFromDic(adressDic, @"parentID")?:@"",second:EncodeStringFromDic(adressDic, @"addressID")?:@""} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    DESC
                    if ([desc isEqualToString:@"success"]) {
                        [UserDetail refreshUserDetail];
                        [BaseToast toast:@"修改成功"];
                    }else{
                        [BaseToast toast:desc];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [BaseToast toast:@"网络不畅"];
                }];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [BaseToast toast:@"网络不畅"];
        }];
    } cancelBlock:nil];
}

#pragma mark ---- 修改学历
- (void)selectAcademicBackground{
    NSArray *dataSource = @[@"大专以下", @"大专", @"本科", @"硕士", @"博士", @"博士后"];
    [BRStringPickerView showStringPickerWithTitle:@"学历" dataSource:dataSource defaultSelValue:@"本科" isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
        [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/update"] parameters:@{@"education":selectValue} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DESC
            if ([desc isEqualToString:@"success"]) {
                [UserDetail refreshUserDetail];
                [BaseToast toast:@"修改成功"];
            }else{
                [BaseToast toast:desc];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [BaseToast toast:@"网络不畅"];
        }];
    } cancelBlock:nil];
}

#pragma mark ---- lazy
- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UserInfoHeadImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserInfoHeadImageTableViewCell class])];
        [_tableView registerClass:[UserInfoBaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserInfoBaseTableViewCell class])];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (NSArray *)imageAssert{
    if (!_imageAssert) {
        _imageAssert = [NSArray array];
    }
    return _imageAssert;
}

@end
