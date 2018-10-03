//
//  JobDetailViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/24.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobDetailViewController.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
#import "UIImageView+WebCache.h"
#import <MBProgressHUD.h>
#import <MJExtension.h>
#import "BaseTableView.h"
#import "THRJob.h"

#import "BannerTableViewCell.h"
#import "JobTableViewCell.h"
#import "JobTimeLineTableViewCell.h"
#import "JobDetailTitleViewTableViewCell.h"
#import "JobDetailExplainTableViewCell.h"

@interface JobDetailViewController ()<UITableViewDelegate,UITableViewDataSource,jobDetailSelectIndexProtocol>
/** tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

/** bottomView*/
@property(nonatomic,strong)UIView* bottomView;

/** THRJob*/
@property (nonatomic, strong) THRJob *job;

/** 上面的补贴*/
@property (nonatomic, strong) NSArray *subsidyList;

/** 下方的几个详情*/
@property(nonatomic,strong)NSArray* detailArray;
@end

@implementation JobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self setUpNavi];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"公司详情";
}

-(void)setJobId:(NSString *)jobId{
    _jobId = jobId;
    __weak typeof(self)weakSelf = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/job/detail"] parameters:@{@"jobID":jobId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            weakSelf.job = [THRJob mj_objectWithKeyValues:EncodeDicFromDic(resultDic, @"job")];
            weakSelf.subsidyList = EncodeArrayFromDic(resultDic, @"subsidyList");
            weakSelf.detailArray = EncodeArrayFromDic(resultDic, @"itemList");
            [weakSelf.tableView reloadData];
            weakSelf.tableView.hidden = NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
}

#pragma mark ------- UITableViewdeleagte && UITbaleViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5 + self.detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerTableViewCell"];
        if (self.job && self.job.company && self.job.company.coverRequestUrl) {
            [cell updateWithURL:@[self.job.company.coverRequestUrl]];
        }
        return cell;
    }
    
    if (indexPath.row == 1) {
        JobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobTableViewCell"];
        [cell detailWithJob:self.job];
        return cell;
    }
    
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.text         = @"推荐好友出清七个工作日后即可获得200元红包";
        cell.imageView.image        = [UIImage imageNamed:@"reminder"];
        
        cell.backgroundColor        = RGBACOLOR(255, 248, 233, 1);
        cell.textLabel.textColor    = RGBACOLOR(237, 178, 88, 1);
        
        cell.textLabel.font         = font(PXGet375Width(23));
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    // 时间线
    if (indexPath.row == 3) {
        JobTimeLineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JobTimeLineTableViewCell"];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;
        [cell updateWithArray:self.subsidyList andContent:self.job.subsidyDesc];
        return cell;
    }
    
    // 标题
    if (indexPath.row == 4) {
        JobDetailTitleViewTableViewCell * title = [tableView dequeueReusableCellWithIdentifier:@"JobDetailTitleViewTableViewCell"];
        title.selectDelegate = self;
        return title;
    }
    
    
    // 薪资情况
    if (  indexPath.row == 5) {
        JobDetailExplainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JobDetailExplainTableViewCell"];
        [cell setContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]] andTitle:@"薪资情况"];
        return cell;
    }
    
    // 岗位说明
    if (  indexPath.row == 6) {
        JobDetailExplainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JobDetailExplainTableViewCell"];
        [cell setContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]] andTitle:@"岗位说明"];
        return cell;
    }
    
    // 录用条件
    if (  indexPath.row == 7) {
        JobDetailExplainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JobDetailExplainTableViewCell"];
        [cell setContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]] andTitle:@"录用条件"];
        return cell;
    }
    
    // 食宿条件
    if (  indexPath.row == 8) {
        JobDetailExplainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JobDetailExplainTableViewCell"];
        [cell setContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]] andTitle:@"食宿条件"];
        return cell;
    }
    
    // 其他说明
    if (  indexPath.row == 9) {
        JobDetailExplainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JobDetailExplainTableViewCell"];
        [cell setContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]] andTitle:@"其他说明"];
        return cell;
    }
    
    
    
    BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BaseTableViewCell"];
    
    //
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [BannerTableViewCell cellHeight];
    }
    
    if (indexPath.row == 1) {
        return [JobTableViewCell cellHeightInDetail];
    }
    
    if (indexPath.row == 2) {
        return Get375Width(25);
    }
   
    if (indexPath.row == 3) {
        if (self.job) {
            return [JobTimeLineTableViewCell cellHeightWithContent:self.job.subsidyDesc];
        }
    }
    
    if (indexPath.row == 4) {
        return [JobDetailTitleViewTableViewCell cellHeight];
    }
    
    if (indexPath.row > 4 && indexPath.row < 10) {
        // 取到对应的dic然后 传进去
        return [JobDetailExplainTableViewCell cellHeightWithContent:@[[self.detailArray safeObjectAtIndex:indexPath.row - 5],[self.detailArray safeObjectAtIndex:indexPath.row - 4]]];
    }
    
    return 0;
}

#pragma mark ------- lazy


-(UIView *)bottomView{
    if (!_bottomView) {
        
        _bottomView = [UIView new];
        _bottomView.frame = CGRectMake(0, kScreenHeight - Bottom_iPhoneX_SPACE - PXGet375Width(90), kScreenWidth, PXGet375Width(90));
        
        UIButton* contentCustom = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton* recommand = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton* signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [signButton addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
        
        [contentCustom setTitle:@"联系客服" forState:UIControlStateNormal];
        [contentCustom addTarget:self action:@selector(linxikefu) forControlEvents:UIControlEventTouchUpInside];
        [recommand setTitle:@"推荐好友" forState:UIControlStateNormal];
        [signButton setTitle:@"立即报名" forState:UIControlStateNormal];
        [contentCustom setImage:[UIImage imageNamed:@"customer"] forState:UIControlStateNormal];
        [contentCustom setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        contentCustom.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        contentCustom.titleLabel.font = font(PXGet375Width(28));
        recommand.titleLabel.font     = font(PXGet375Width(28));
        signButton.titleLabel.font    = font(PXGet375Width(28));
        
        signButton.backgroundColor = CommonBlue;
        recommand.backgroundColor = RGBACOLOR(246, 188, 77, 1);
        [_bottomView sd_addSubviews:@[contentCustom,recommand,signButton]];
        
        contentCustom.sd_layout
        .widthRatioToView(_bottomView, 0.333)
        .topSpaceToView(_bottomView, 0)
        .bottomSpaceToView(_bottomView, 0)
        .leftSpaceToView(_bottomView, 0);
        
        recommand.sd_layout
        .widthRatioToView(_bottomView, 0.333)
        .topSpaceToView(_bottomView, 0)
        .bottomSpaceToView(_bottomView, 0)
        .leftSpaceToView(contentCustom, 0);
        
        signButton.sd_layout
        .widthRatioToView(_bottomView, 0.333)
        .topSpaceToView(_bottomView, 0)
        .bottomSpaceToView(_bottomView, 0)
        .leftSpaceToView(recommand, 0);
        
        UIView* line = [UIView new];
        line.backgroundColor = RGBACOLOR(223, 223, 223, 1);
        [contentCustom addSubview:line];
        line.sd_layout
        .heightIs(1)
        .topSpaceToView(contentCustom, 0)
        .rightSpaceToView(contentCustom, 0)
        .leftSpaceToView(contentCustom, 0);
        
    }
    return _bottomView;
}

- (void)signAction{
    // 去报名
    if (IsStrEmpty(self.jobId)) {
        return;
    }
    
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/job/addRecord"] parameters:@{@"jobID":self.jobId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* resultDic = responseObject;
        // 这边只能判断resultCode
        NSString* resultCode = EncodeStringFromDic(resultDic, @"resultCode");
        if ([resultCode isEqualToString:@"000000"]) {
            [BaseToast toast:@"报名成功"];
        }else if([resultCode isEqualToString:@"303002"]){
            [BaseToast toast:@"已经报过名了"];
        }else{
            [BaseToast toast:@"当前岗位不存在"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"网络不畅报名失败"];
    }];
}

// 滚动
- (void)selectWithIndex:(NSUInteger)index{
//    0 - > 5
    
    if (self.detailArray.count <= index) {
        return;
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index + 5 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - PXGet375Width(90)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
   
        [_tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:@"BannerTableViewCell"];
        [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:@"JobTableViewCell"];
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"BaseTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JobTimeLineTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([JobTimeLineTableViewCell class])];
        [_tableView registerClass:[JobDetailTitleViewTableViewCell class] forCellReuseIdentifier:@"JobDetailTitleViewTableViewCell"];
        [_tableView registerClass:[JobDetailExplainTableViewCell class] forCellReuseIdentifier:@"JobDetailExplainTableViewCell"];
        _tableView.hidden = YES;
    }
    return _tableView;
}


- (void)linxikefu{
//    [BaseToast toast:[UserDetail getCustomPhone]];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[UserDetail getCustomPhone]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
   
}
@end
