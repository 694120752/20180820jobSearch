//
//  TodayHotJobViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "TodayHotJobViewController.h"
#import "JobTableViewCell.h"
#import "BaseTableView.h"
#import "FSSegmentTitleView.h"
#import <MJRefresh.h>
#import "THRJobListRequest.h"
#import "FSPageContentView.h"
#import "TodayChildVcViewController.h"
#import "BaseToast.h"

@interface TodayHotJobViewController ()<FSSegmentTitleViewDelegate,FSPageContentViewDelegate>
@property (nonatomic, strong) FSPageContentView *pageView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation TodayHotJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self.view addSubview:self.titleView];
    [self getLocationDataAndReSertPage];
}

- (void)setUpNavi{
    self.navBar.titleLabel.text = @"今日热招";
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
}

- (void)getLocationDataAndReSertPage{
    // 先去 请求热门城市
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/address/list"] parameters:@{@"level":@"2",@"hotFlag":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DESC
        if ([desc isEqualToString:@"success"]) {
            NSArray* cityArray = EncodeArrayFromDic(resultDic, @"dataList");
            
            NSMutableArray* titleArray = [NSMutableArray array];
            NSMutableArray* vcArray = [NSMutableArray array];
            
            for (NSDictionary* cityDic in cityArray) {
                [titleArray addObject:EncodeStringFromDic(cityDic, @"name")];
                TodayChildVcViewController* childVc = [[TodayChildVcViewController alloc]initWithCityID:EncodeStringFromDic(cityDic, @"name")];
                [vcArray addObject:childVc];
            }
            
            weakSelf.titleView.titlesArr = [titleArray copy];
            weakSelf.pageView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - PXGet375Width(100)) childVCs:vcArray parentVC:self delegate:self];
            [weakSelf.view addSubview:weakSelf.pageView];
            
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


#pragma mark --------------- titleViewDelegate  && FSPageContentDelegate

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.pageView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
}


#pragma mark ------- lazy
- (FSSegmentTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, PXGet375Width(100)) titles:@[] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
        _titleView.titleSelectColor = CommonBlue;
        _titleView.titleNormalColor = RGBACOLOR(116, 116, 116, 1);
        _titleView.indicatorColor = CommonBlue;
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}

//-(FSPageContentView *)pageView{
//    if (!_pageView) {
//        _pageView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - PXGet375Width(100)) childVCs:@[] parentVC:self delegate:self];
//    }
//    return _pageView;
//}
@end
