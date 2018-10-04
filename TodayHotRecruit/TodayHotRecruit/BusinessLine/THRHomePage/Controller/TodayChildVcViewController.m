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
#import "JobDetailViewController.h"
#import "BaseNavigationBar.h"

@interface TodayChildVcViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) BaseTableView *listView;
@property (nonatomic, assign) NSUInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *KeyWord;
@property (nonatomic,strong) BaseNavigationBar *mNavBar;
@end

@implementation TodayChildVcViewController

- (instancetype)initWithCityID:(NSString *)cityID{
    self = [super init];
    _cityID = cityID;
    return self;
}

- (instancetype)initWithKeyWord:(NSString *)word{
    self = [super init];
    _KeyWord = word;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listView];
    
    if (IsStrEmpty(_cityID)) {
        // 从搜索页进来的
        self.listView.frame = CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y);
        self.navigationController.navigationBarHidden = YES;
        [self.view addSubview:self.mNavBar];
        _mNavBar.titleLabel.text = _KeyWord;
    }
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THRJob *job = self.dataArray[indexPath.row];
    JobDetailViewController *detail = [JobDetailViewController new];
    detail.jobId = job.id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
            } andCityID:weakSelf.cityID andKeyWord:weakSelf.KeyWord];
        }];
        
        _listView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [THRJobListRequest getJobDataWithPage:weakSelf.pageNumber andTableView:weakSelf.listView andSuccess:^(NSArray *dataList) {
                weakSelf.dataArray = [[weakSelf.dataArray arrayByAddingObjectsFromArray:dataList] mutableCopy];
            } andCityID:weakSelf.cityID andKeyWord:weakSelf.KeyWord];
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


-(BaseNavigationBar *)mNavBar{
    if (!_mNavBar) {
         _mNavBar = [BaseNavigationBar navigationBar];
        [_mNavBar.backButton addTarget:self
                                action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
        _mNavBar.backgroundColor = CommonBlue;
        _mNavBar.barItem.backgroundColor = CommonBlue;

    }
    return _mNavBar;
}

-(void)onBack:(id)sender{
    NSArray *vcs = self.navigationController.viewControllers;
    if (vcs.count > 1 && [vcs objectAtIndex:vcs.count-1] == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
