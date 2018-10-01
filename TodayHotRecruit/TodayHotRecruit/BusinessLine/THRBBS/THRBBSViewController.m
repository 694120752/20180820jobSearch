//
//  THRBBSViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRBBSViewController.h"
#import "BBSBaseViewController.h"
#import "SPPageMenu.h"
#import "BBSModel.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#define SCROLLVIEW_MARGIN 40
#define SCROLLVIEW_HEIGHT kScreenHeight - SCROLLVIEW_MARGIN - 120
@interface THRBBSViewController () <SPPageMenuDelegate, UIScrollViewDelegate, BBSBaseViewControllerDataSource>
@property (nonatomic,strong)SPPageMenu* topMenu;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,assign)NSInteger tabIndex;

@property (nonatomic,strong)NSMutableArray* vcArray;
@property (nonatomic, strong)NSArray* currentDataSource;

/** titleDTO*/
@property (nonatomic, strong) NSMutableArray *titleDto;
@end

@implementation THRBBSViewController

- (NSMutableArray *)vcArray {
    if (!_vcArray) {
        _vcArray = [NSMutableArray array];
    }
    return _vcArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabIndex = 0;
    
    // 配置标题 子控制器
    [self setupViews];

    [self setupNavi];
}

- (void)setupNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"交流天地";
    self.navBar.backButton.hidden = YES;
}

- (void)setupViews {
    [self setupTopMenu];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCROLLVIEW_MARGIN + 64,kScreenWidth, SCROLLVIEW_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return  _scrollView;
}

-(void)loadData {
    // 模拟请求
    // 根据 tabIndex 决定调用接口
    
    if (IsArrEmpty(self.vcArray) || IsArrEmpty(self.titleDto)) {
        return;
    }
    
    BBSBaseViewController* vc = self.vcArray[self.tabIndex];
   
    
    // 暂时不管上拉下拉 先去搞数据
    NSDictionary *dic = self.titleDto[self.tabIndex];
    // 获取帖子列表
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/forum/list"] parameters:@{@"pageNo":@"1",@"categoryID":EncodeStringFromDic(dic, @"id"),@"pageSize":@(10)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*resultDic=responseObject;
        NSMutableArray* tempSourceData = [EncodeArrayFromDic(resultDic, @"dataList") mutableCopy];
        NSMutableArray* tempTargetData = [NSMutableArray array];
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
         // 为每条帖子获取评论
        for (NSDictionary *dic in tempSourceData) {
            BBSModel* model = [BBSModel encodeFromDic:dic];
            [tempTargetData addObject:model];
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/forumComment/list"] parameters:@{@"pageNo":@"1",@"pageSize":@"99",@"forumID":model.bbsID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary*resultDic=responseObject;
                    model.comments = [CommentModel mj_objectArrayWithKeyValuesArray:EncodeArrayFromDic(resultDic, @"dataList")];//[NSMutableArray mj_objectArrayWithKeyValuesArray:];
                    dispatch_group_leave(group);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    dispatch_group_leave(group);
                }];
                
            });

        }
   
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 所有的都请求完了
                weakSelf.currentDataSource = [tempTargetData copy];
                [vc reloadData];
            });
        });
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"网络不通"];
    }];
    
   
}

#pragma mark UI

-(void)setupTopMenu {
    
    SPPageMenu* menu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40) trackerStyle:SPPageMenuTrackerStyleLine];
    self.topMenu = menu;
    [self.view addSubview:menu];
    [self.view addSubview:self.scrollView];

    [menu setSelectedItemTitleColor: [UIColor colorWithRed:93/255.0 green:157/255.0 blue:248/255.0 alpha:1]];
    menu.delegate = self;
    menu.bridgeScrollView = self.scrollView;

    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    // 请求分类
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/forumCategory/list"] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* resultDic = responseObject;
        [weakSelf.titleDto removeAllObjects];
        weakSelf.titleDto = [EncodeArrayFromDic(resultDic, @"dataList") mutableCopy];
        
        // 配置标题和子控制器
        NSMutableArray *titleArray = [NSMutableArray array];
        for (NSUInteger i = 0; i< weakSelf.titleDto.count ; i++) {
            [titleArray addObject:EncodeStringFromDic(weakSelf.titleDto[i], @"name")];
            
            BBSBaseViewController* vc = [[BBSBaseViewController alloc] init];
            [weakSelf addChildViewController:vc];
            vc.view.frame = CGRectMake( i * kScreenWidth, 0, kScreenWidth, SCROLLVIEW_HEIGHT);
            vc.dataSource = self;
            [weakSelf.vcArray addObject:vc];
            [weakSelf.scrollView addSubview:vc.view];
            
            weakSelf.scrollView .contentOffset = CGPointMake(kScreenWidth*i, 0);
            weakSelf.scrollView .contentSize = CGSizeMake(titleArray.count*kScreenWidth, 0);

        }
        
        
        [menu setItems:[titleArray copy] selectedItemIndex:weakSelf.tabIndex];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
    
    
}



#pragma mark SPPSegmentDelegate

-(void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (!self.scrollView.isDragging) { 
        if (labs(toIndex - fromIndex) >= 2) {
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:YES];
        }
    }
    
    if (self.vcArray.count <= toIndex) {return;}
    
    self.tabIndex = toIndex;
    
    BBSBaseViewController *targetViewController = self.vcArray[toIndex];

    if (targetViewController.tableDataSource == nil) {
        [self loadData];
    }
    
    if ([targetViewController isViewLoaded]) return;
 
    targetViewController.view.frame = CGRectMake(kScreenWidth * toIndex, 0, kScreenWidth, SCROLLVIEW_HEIGHT);
    [_scrollView addSubview:targetViewController.view];
}

#pragma mark BBSDataSource
-(NSArray *)datasourceForBBSBaseViewController:(BBSBaseViewController *)BBSBaseViewController {
    return self.currentDataSource;
}

-(void)BBSBaseViewControllerDidRefreshData:(BBSBaseViewController *)BBSBaseViewController {
    [self loadData];
}

#pragma mark ------ lazy
-(NSMutableArray *)titleDto{
    if (!_titleDto) {
        _titleDto = [NSMutableArray array];
    }
    return _titleDto;
}

@end
