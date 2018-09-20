//
//  TodayHotJobViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "TodayHotJobViewController.h"
#import "JobTableViewCell.h"
#import "BaseTableView.h"
#import "FSSegmentTitleView.h"
#import <MJRefresh.h>

@interface TodayHotJobViewController ()
@property (nonatomic, strong)BaseTableView  *tableView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation TodayHotJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    
}

- (void)setUpNavi{
    self.navBar.titleLabel.text = @"今日热招";
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
}

#pragma mark ------- tableView
- (BaseTableView *)tableView{
    if (!_tableView) {
        // title高100px
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - PXGet375Width(100)) style:UITableViewStylePlain];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
        }];
        
        [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JobTableViewCell class])];
    
    }
    return _tableView;
}
@end
