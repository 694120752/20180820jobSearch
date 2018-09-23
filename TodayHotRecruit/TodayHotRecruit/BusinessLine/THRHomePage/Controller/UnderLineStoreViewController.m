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

@interface UnderLineStoreViewController ()<FSSegmentTitleViewDelegate,FSPageContentViewDelegate>
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) FSPageContentView *contentPage;
@end

@implementation UnderLineStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self.view addSubview:self.titleView];
    //self.view addSubview:self.contentPage];
    // 获取热门城市
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self getLocationAndSetupContent];
    
}

- (void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"线下门店";
}


#pragma mark --------------- titleViewDelegate  && FSPageContentDelegate

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.contentPage.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
}


- (void)getLocationAndSetupContent{
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
                UnderLineStoreChildVc* childVc = [[UnderLineStoreChildVc alloc]initWithCityID:EncodeStringFromDic(cityDic, @"addressID") andProvinceID:EncodeStringFromDic(cityDic, @"parentID")];
                [vcArray addObject:childVc];
                
            }
            
            weakSelf.titleView.titlesArr = [titleArray copy];
            
            weakSelf.contentPage = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - PXGet375Width(100) - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) childVCs:[vcArray copy] parentVC:weakSelf delegate:weakSelf];
            weakSelf.contentPage.collectionView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
            weakSelf.contentPage.bgColor = RGBACOLOR(240, 240, 240, 1);
            weakSelf.contentPage.backgroundColor = RGBACOLOR(240, 240, 240, 1);
            [weakSelf.view addSubview:weakSelf.contentPage];
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

#pragma mark ---- lazy

-(FSSegmentTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, PXGet375Width(100)) titles:@[] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
        _titleView.titleSelectColor = CommonBlue;
        _titleView.indicatorColor = CommonBlue;
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}

@end

