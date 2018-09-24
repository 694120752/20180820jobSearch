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

@interface JobDetailViewController ()
/** tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

/** bottomView*/
@property(nonatomic,strong)UIView* bottomView;
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

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

@end
