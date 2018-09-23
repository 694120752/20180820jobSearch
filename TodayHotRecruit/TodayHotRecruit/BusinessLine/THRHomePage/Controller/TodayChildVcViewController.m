//
//  TodayChildVcViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "TodayChildVcViewController.h"
#import "THRJobListRequest.h"
#import "BaseTableView.h"
#import "JobTableViewCell.h"
#import <MJRefresh.h>

@interface TodayChildVcViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) BaseTableView *listView;
@property (nonatomic, assign) NSUInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TodayChildVcViewController

- (instancetype)initWithCityID:(NSString *)cityID{
    self = [super init];
    _cityID = cityID;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listView];
}

#pragma mark --------------------- tableViewDelegate && DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobTableViewCell* base = [[JobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
    base.job = self.dataArray[indexPath.row];
    return base;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobTableViewCell selfHeight];
}

#pragma mark ------------------- lazy

-(BaseTableView *)listView{
    if (!_listView) {
        _listView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - PXGet375Width(100) - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        [_listView registerClass:[JobTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JobTableViewCell class])];
        _listView.delegate = self;
        _listView.dataSource = self;
        __weak typeof(self)weakSelf = self;
        
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [THRJobListRequest getJobDataWithPage:weakSelf.pageNumber andTableView:weakSelf.listView andSuccess:^(NSArray *dataList) {
                 weakSelf.dataArray = [dataList mutableCopy];
            } andCityID:weakSelf.cityID andKeyWord:nil];
        }];
        
        _listView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [THRJobListRequest getJobDataWithPage:weakSelf.pageNumber andTableView:weakSelf.listView andSuccess:^(NSArray *dataList) {
                weakSelf.dataArray = [[weakSelf.dataArray arrayByAddingObjectsFromArray:dataList] mutableCopy];
            } andCityID:weakSelf.cityID andKeyWord:nil];
        }];
        
        [_listView.mj_header beginRefreshing];
    }
    return _listView;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
