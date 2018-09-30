//
//  MyfundsViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "MyfundsViewController.h"
#import "BaseToast.h"
#import "BaseTableView.h"
#import <MJRefresh.h>
#import "THRRequestManager.h"
@interface MyfundsViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 提现记录*/
@property(nonatomic,strong)BaseTableView* tableView;
/** dataArray*/
@property(nonatomic,strong)NSMutableArray* dataArray;
@end

@implementation MyfundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self.view addSubview:self.tableView];

}

- (void)setupNavi{
    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBarItemView.backgroundColor = [UIColor clearColor];
    self.navBar.bottomLine.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView* image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"withdrawBack"]];
    image.frame = CGRectMake(0, 0, kScreenWidth, PXGet375Width(370));
    [self.view addSubview:image];
    [self.view bringSubviewToFront:self.navBar];
    
// 分数
    UILabel *scoreLabel = [UILabel new];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.font = font(Get375Width(28));
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [image addSubview:scoreLabel];
    
    // 这边刷新一下 取最新的
    [UserDetail refreshUserDetailWith:^{
        scoreLabel.text = EncodeStringFromDic([UserDetail getDetail], @"amount");
    } andFailedBlock:^(NSString *reason) {
        [BaseToast toast:@"网络不畅"];
    }];
    
    scoreLabel.sd_layout
    .centerXEqualToView(image)
    .centerYEqualToView(image)
    .widthRatioToView(image, 1)
    .heightIs(PXGet375Width(80));
    
    UILabel *mark = [UILabel new];
    mark.textAlignment = NSTextAlignmentCenter;
    mark.textColor = RGBACOLOR(239, 224, 174, 1);
    mark.text = @"我的资金（元）";
    mark.font = font(PXGet375Width(18));
    [image addSubview:mark];
    mark.sd_layout
    .topSpaceToView(scoreLabel, 5)
    .heightIs(PXGet375Width(30))
    .rightSpaceToView(image, 0)
    .leftSpaceToView(image, 0);
    
    UIButton *withdrawCash = [UIButton buttonWithType:UIButtonTypeCustom];
    [image addSubview:withdrawCash];
    withdrawCash.layer.cornerRadius = 8;
    withdrawCash.clipsToBounds = YES;
    withdrawCash.backgroundColor = RGBACOLOR(247, 201, 71, 1);
    [withdrawCash setTitle:@"提现" forState:UIControlStateNormal];
    withdrawCash.titleLabel.font = font(PXGet375Width(22));
    [withdrawCash setTitleColor:RGBACOLOR(53, 70, 92, 1) forState:UIControlStateNormal];
    withdrawCash.sd_layout
    .widthIs(PXGet375Width(220))
    .heightIs(PXGet375Width(75))
    .centerXEqualToView(image)
    .bottomSpaceToView(image, -PXGet375Width(75)/2);
    
}

#pragma mark --------- TableViewDelegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dataDci = self.dataArray[indexPath.row];
    if (dataDci) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@成功提现%@元",EncodeStringFromDic(dataDci, @"userNickName"),EncodeStringFromDic(dataDci, @"amount")];
        cell.detailTextLabel.text = EncodeStringFromDic(dataDci, @"createTime");
    }
    
    return cell;
}


-(BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, PXGet375Width(75)/2 +PXGet375Width(370) + 10, kScreenWidth, kScreenHeight - PXGet375Width(75)/2 - PXGet375Width(370) - 10 - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        __weak typeof(self)weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/eventRecord/list"] parameters:@{@"type":@"2"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DESC
                if ([desc isEqualToString:@"success"]) {
                    weakSelf.dataArray = [EncodeArrayFromDic(resultDic, @"dataList") mutableCopy];
                }
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf.tableView.mj_header endRefreshing];
            }];
        }];
        [_tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}

@end
