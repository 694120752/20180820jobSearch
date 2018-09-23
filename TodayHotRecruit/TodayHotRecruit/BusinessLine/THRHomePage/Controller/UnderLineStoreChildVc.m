//
//  UnderLineStoreChild.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UnderLineStoreChildVc.h"
#import "BaseTableView.h"
#import "UnderLineCardTableViewCell.h"
#import "THRRequestManager.h"
#import <MJRefresh.h>
#import <MJExtension.h>

NSUInteger const listSize = 10;

typedef void(^successBlick)(NSArray * data);

@interface UnderLineStoreChildVc ()<UITableViewDelegate,UITableViewDataSource>
/**  cityID*/
@property(nonatomic,strong)NSString* cityID;
/** provinceID*/
@property(nonatomic,strong)NSString* provinceID;
/** tableView*/
@property(nonatomic,strong)BaseTableView* listView;
/** dataSource*/
@property(nonatomic,strong)NSMutableArray* dataArray;
/** pageCount*/
@property(nonatomic,assign)NSUInteger pageCount;
@end

@implementation UnderLineStoreChildVc

- (instancetype)initWithCityID:(NSString *)cityID andProvinceID:(NSString *)provinceID{
    self = [super init];
    _cityID = cityID;
    _provinceID = provinceID;
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.view addSubview:self.listView];
}

#pragma mark ---- UITableViewDelegate && DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UnderLineCardTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UnderLineCardTableViewCell class])];
    //
    cell.dataDic = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UnderLineCardTableViewCell cellHeightWithDic:self.dataArray[indexPath.row]];
}
- (void)requestOutLineShopWithCompare:(BOOL)isHeader{
    __weak typeof(self)weakSelf = self;
    [THRRequestManager.manager.setDefaultHeader POST:[HTTP stringByAppendingString:@"/shop/list"] parameters:@{@"province":self.provinceID,@"city":self.cityID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* resultDic=responseObject;
        NSArray *  tempData = EncodeArrayFromDic(resultDic, @"dataList");
        
        if (isHeader) {
            weakSelf.dataArray = [tempData mutableCopy];
        }else{
            weakSelf.dataArray = [[weakSelf.dataArray arrayByAddingObjectsFromArray:tempData] mutableCopy];
        }
        
        [weakSelf.listView.mj_header endRefreshing];
        if (tempData.count < listSize) {
            [weakSelf.listView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.listView.mj_footer endRefreshing];
        }
        
        [weakSelf.listView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    }];
}

#pragma mark ----- lazy
-(BaseTableView *)listView{
    if (!_listView) {
        _listView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - PXGet375Width(100) - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _listView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
        _listView.delegate = self;
        _listView.dataSource = self;
        
        [_listView registerClass:[UnderLineCardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UnderLineCardTableViewCell class])];
        
        __weak typeof(self)weakSelf = self;
        _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageCount = 0;
            [weakSelf.listView.mj_footer resetNoMoreData];
            [weakSelf requestOutLineShopWithCompare:YES];
        }];
        _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageCount ++;
            [weakSelf requestOutLineShopWithCompare:NO];
        }];
        _listView.mj_footer.backgroundColor = RGBACOLOR(240, 240, 240, 1);
        _listView.mj_header.backgroundColor = RGBACOLOR(240, 240, 240, 1);
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
