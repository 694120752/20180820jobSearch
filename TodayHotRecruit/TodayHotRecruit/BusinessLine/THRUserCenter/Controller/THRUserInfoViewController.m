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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavi];
    
    [self.view addSubview:self.tableView];
}

-(void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"个人信息";
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
            cell.labelCase = @"userName";
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
            
        default:
            break;
    }
}

#pragma mark ---- THRPhotoDelegate
-(void)pickResult:(NSArray *)photoArray andAssert:(NSArray *)asset{
    self.imageAssert = asset;
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    if (!IsArrEmpty(photoArray)) {
        UIImage* photo = photoArray.firstObject;
        NSData* photoData = UIImageJPEGRepresentation(photo, 0.8);
        [THRUploadFile upLoadFileWithData:@[photoData] andTitleArray:nil UploadFailedReason:^(NSString *reasonStr, THRUploadFailedReason reason) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                hud.label.text = NSLocalizedString(reasonStr, @"图像上传出现问题！");
                [hud hideAnimated:YES afterDelay:1];
            });
        } UploadProgressBlock:^(float progress) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                hud.progress = progress;
            });
        } UploadSuccessBlock:^(NSString *filePath) {
            [UserDetail refreshUserDetail];
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                hud.customView = imageView;
                hud.mode = MBProgressHUDModeCustomView;
                hud.label.text = NSLocalizedString(@"上传成功", @"HUD completed title");
                [hud hideAnimated:YES afterDelay:1];
            });
        }];
        
    }
}

#pragma mark ---- lazy
-(BaseTableView *)tableView{
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

-(NSArray *)imageAssert{
    if (!_imageAssert) {
        _imageAssert = [NSArray array];
    }
    return _imageAssert;
}

@end
