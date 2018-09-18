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

@interface THRUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 主体tableVIew*/
@property(nonatomic,strong)BaseTableView* tableView;
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
        }
            break;
            
        default:
            break;
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

@end
