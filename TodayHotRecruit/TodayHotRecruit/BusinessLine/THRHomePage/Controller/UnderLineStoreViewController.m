//
//  UnderLineStoreViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UnderLineStoreViewController.h"
#import "FSScrollContentView.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
#import "UnderLineCardTableViewCell.h"
#import "UnderLineStoreChildVc.h"

@interface UnderLineStoreViewController ()
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *contentPage;
@end

@implementation UnderLineStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    
    // 获取热门城市
    [self getLocationAndSetupContent];
}

- (void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"线下门店";
}

- (void)getLocationAndSetupContent{
    // 先去 请求热门城市
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/address/list"] parameters:@{@"level":@"2",@"hotFlag":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DESC
        if ([desc isEqualToString:@"success"]) {
//            NSArray* cityArray = EncodeArrayFromDic(resultDic, @"dataList");
//
//            NSMutableArray* titleArray = [NSMutableArray array];
//            NSMutableArray* vcArray = [NSMutableArray array];
//
//            for (NSDictionary* cityDic in cityArray) {
//                [titleArray addObject:EncodeStringFromDic(cityDic, @"name")];
//                TodayChildVcViewController* childVc = [[TodayChildVcViewController alloc]initWithCityID:EncodeStringFromDic(cityDic, @"name")];
//                [vcArray addObject:childVc];
//            }
//
//            weakSelf.titleView.titlesArr = [titleArray copy];
//            weakSelf.pageView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - PXGet375Width(100)) childVCs:vcArray parentVC:self delegate:self];
//            [weakSelf.view addSubview:weakSelf.pageView];
            
        }else{
            [BaseToast toast:desc];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        [BaseToast toast:@"网络不畅"];
        
    }];
}

@end
