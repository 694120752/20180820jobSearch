//
//  THRMySigninViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/24.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRMySigninViewController.h"
#import "BaseTableView.h"
#import "MySignViewModel.h"
#import "JobTableViewCell.h"
#import <MJRefresh.h>
#import "THRRequestManager.h"
#import <MJExtension.h>

@interface THRMySigninViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 报名列表*/
@property(nonatomic,strong)BaseTableView* tableView;

/** model*/
@property(nonatomic,strong)MySignViewModel* model;
@end

@implementation THRMySigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self.view addSubview:self.tableView];
}

- (void)setupNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"我的报名";
}

#pragma mark --------- UITableViewDelegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JobTableViewCell class])];
    [cell mySignWithJob:self.model.dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobTableViewCell cellHeightInMySign];
}


#pragma mark --------------- data

- (void)getSignDataWithComponent:(ComponentPart)part{
    
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/jobRecord/list"] parameters:@{@"pageNo":@(self.model.pageNumber),@"pageSize":@(self.model.pageSize)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* resultDic = responseObject;
        NSMutableArray *tempData = [NSMutableArray array];
        for (NSDictionary * tempDic in EncodeArrayFromDic(resultDic, @"dataList")) {
            THRJob * job = [THRJob mj_objectWithKeyValues:EncodeDicFromDic(tempDic, @"job")];
            [tempData addObject:job];
        }
        if (part == RefreshHeader) {
            weakSelf.model.dataArray = tempData;
        }else{
            weakSelf.model.dataArray = [[weakSelf.model.dataArray arrayByAddingObjectsFromArray:tempData] mutableCopy];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        if (tempData.count < weakSelf.model.pageSize) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark ---- lazy

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JobTableViewCell class])];
        
        __weak typeof(self)weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.model.pageNumber = 1;
            [weakSelf getSignDataWithComponent:RefreshHeader];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.model.pageNumber ++;
            [weakSelf getSignDataWithComponent:RefreshFooter];
        }];
        
        [_tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}

- (MySignViewModel *)model{
    if (!_model) {
        _model = [[MySignViewModel alloc]init];
        _model.pageSize = 10;
        _model.pageNumber = 1;
        _model.dataArray = [NSMutableArray array];
    }
    return _model;
}


@end
