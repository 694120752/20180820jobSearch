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
            
        default:
        {
            BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaseTableViewCell class])];
            return cell;
        }
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
        
        [_tableView registerClass:[UserInfoHeadImageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserInfoHeadImageTableViewCell class])];
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
        
    }
    return _tableView;
}

@end
