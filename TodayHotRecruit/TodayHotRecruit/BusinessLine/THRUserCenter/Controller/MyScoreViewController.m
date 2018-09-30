//
//  MyScoreViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "MyScoreViewController.h"
#import "UIButton+WebCache.h"
#import <MJRefresh.h>
#import "THRRequestManager.h"

@interface MyScoreViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 积分列表*/
@property (nonatomic, strong) UITableView *scoreTableView;

/** 积分数组*/
@property (nonatomic, strong) NSMutableArray *scoreArray;
@end

@implementation MyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    // 第一行 三个控件
    [self setUpFirstLine];
    
    // 下面列表
    [self setUpTableView];
}

- (void)setupNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"我的积分";
}

- (void)setUpFirstLine{
    
    UIView *firstView = [UIView new];
    firstView.frame = CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, PXGet375Width(250));
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    // 360 105 头像按钮
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerButton sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic([UserDetail getDetail], @"portraitRequestUrl")] forState:UIControlStateNormal];
    headerButton.imageView.layer.cornerRadius = PXGet375Width(100) / 2;
    headerButton.clipsToBounds = YES;
    [firstView addSubview:headerButton];
    headerButton.sd_layout
    .centerYEqualToView(firstView)
    .leftSpaceToView(firstView, PXGet375Width(30))
    .widthIs(PXGet375Width(360))
    .heightIs(PXGet375Width(105));
    
    headerButton.imageView.sd_layout
    .centerYEqualToView(headerButton)
    .widthIs(PXGet375Width(100))
    .heightIs(PXGet375Width(100))
    .leftSpaceToView(headerButton, 0);
    
    headerButton.titleLabel.sd_layout
    .centerYEqualToView(headerButton)
    .leftSpaceToView(headerButton.imageView, PXGet375Width(20))
    .rightSpaceToView(headerButton, 0)
    .heightRatioToView(headerButton, 1);
    
    [headerButton setTitle:EncodeStringFromDic([UserDetail getDetail], @"nickName") forState:UIControlStateNormal];
    [headerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    // 右侧两个label 当前积分 积分活动
    UILabel *currentScore = [UILabel new];
    UILabel *scoreActive = [UILabel new];
    [firstView addSubview:currentScore];
    [firstView addSubview:scoreActive];
    
    currentScore.textAlignment = NSTextAlignmentCenter;
    scoreActive.textAlignment = NSTextAlignmentCenter;
    
    currentScore.sd_layout
    .rightSpaceToView(firstView, Get375Width(30))
    .widthIs(PXGet375Width(210))
    .heightIs(PXGet375Width(60))
    .topSpaceToView(firstView, PXGet375Width(50));
    
    scoreActive.sd_layout
    .rightSpaceToView(firstView, Get375Width(30))
    .widthIs(PXGet375Width(210))
    .heightIs(PXGet375Width(60))
    .topSpaceToView(currentScore, PXGet375Width(20));
    
    scoreActive.backgroundColor = RGBACOLOR(255, 193, 17, 1);
    scoreActive.layer.cornerRadius = 8;
    scoreActive.textColor = [UIColor whiteColor];
    scoreActive.clipsToBounds = YES;
    currentScore.backgroundColor = CommonBlue;
    currentScore.layer.cornerRadius = 8;
    currentScore.clipsToBounds = YES;
    currentScore.textColor = [UIColor whiteColor];
    
    currentScore.text = [NSString stringWithFormat:@"当前积分%@",EncodeStringFromDic([UserDetail getDetail], @"points")];
    scoreActive.text = @"积分活动";
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [firstView addSubview:bottomLine];
    bottomLine.sd_layout
    .bottomSpaceToView(firstView, 0)
    .heightIs(1)
    .rightSpaceToView(firstView, 0)
    .leftSpaceToView(firstView, 0);
}

- (void)setUpTableView{
    self.scoreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(250), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - PXGet375Width(250) - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
    self.scoreTableView.delegate = self;
    self.scoreTableView.dataSource = self;
    [self.view addSubview:self.scoreTableView];
    
    self.scoreTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        __weak typeof(self)weakSelf = self;
        [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/eventRecord/list"] parameters:@{@"type":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DESC
            if ([desc isEqualToString:@"success"]) {
                weakSelf.scoreArray = [EncodeArrayFromDic(resultDic, @"dataList") mutableCopy];
            }
            
            [weakSelf.scoreTableView.mj_header endRefreshing];
            [weakSelf.scoreTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.scoreTableView.mj_header endRefreshing];
        }];
    }];
    [self.scoreTableView.mj_header beginRefreshing];
    self.scoreTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


#pragma mark ------------ delegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.scoreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSDictionary *scoreDic = self.scoreArray[indexPath.row];
    cell.textLabel.text = EncodeStringFromDic(scoreDic, @"eventContent");
    cell.detailTextLabel.text = EncodeStringFromDic(scoreDic, @"createTime");
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
