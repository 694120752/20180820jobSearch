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
#import "BaseTableView.h"

#import "THRJob.h"
#import "BannerTableViewCell.h"
#import "JobTableViewCell.h"

@interface JobDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

/** bottomView*/
@property(nonatomic,strong)UIView* bottomView;

/** THRJob*/
@property (nonatomic, strong) THRJob *job;
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
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/job/detail"] parameters:@{@"jobID":jobId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
    } failure:nil];
}

#pragma mark ------- UITableViewdeleagte && UITbaleViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerTableViewCell"];
        return cell;
    }
    
    BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BaseTableViewCell"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [BannerTableViewCell cellHeight];
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

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    
        [_tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:@"BannerTableViewCell"];
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"BaseTableViewCell"];
    }
    return _tableView;
}

@end
