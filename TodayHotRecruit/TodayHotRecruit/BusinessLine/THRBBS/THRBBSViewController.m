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
#define SCROLLVIEW_MARGIN 40
#define SCROLLVIEW_HEIGHT kScreenHeight - SCROLLVIEW_MARGIN - 120
@interface THRBBSViewController () <SPPageMenuDelegate, UIScrollViewDelegate, BBSBaseViewControllerDataSource>
@property (nonatomic,strong)SPPageMenu* topMenu;

@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic,strong)NSArray* recommandData;
@property (nonatomic,strong)NSArray* moodData;;

@property (nonatomic,assign)NSInteger tabIndex;

@property (nonatomic,strong)NSMutableArray* vcArray;
@property (nonatomic, strong)NSArray* currentDataSource;
@end

@implementation THRBBSViewController
-(NSMutableArray *)vcArray {
    if (!_vcArray) {
        _vcArray = [NSMutableArray array];
    }
    return _vcArray;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabIndex = 0;
    
    [self setupViews];
    
    [self loadData];
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
    BBSBaseViewController* vc = self.vcArray[self.tabIndex];
    NSArray* datasource = @[];
    if (self.tabIndex == 0)  {
         datasource = [BBSModel getTempModels];
    } else {
        datasource = [BBSModel getTempModels2];
    }
    self.currentDataSource = datasource;
    [vc reloadData];
}

#pragma mark UI

-(void)setupTopMenu {
    
    SPPageMenu* menu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40) trackerStyle:SPPageMenuTrackerStyleLine];
    self.topMenu = menu;
    [self.view addSubview:menu];
    [self.view addSubview:self.scrollView];
    NSArray* titleArray = @[@"推荐" ,@"情感",@"工作",@"心情",@"交友",@"二手"];
    [menu setSelectedItemTitleColor: [UIColor colorWithRed:93/255.0 green:157/255.0 blue:248/255.0 alpha:1]];
    menu.delegate = self;
    menu.bridgeScrollView = self.scrollView;

    for (NSInteger i = 0; i < titleArray.count; i++) {
        BBSBaseViewController* vc = [[BBSBaseViewController alloc] init];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake( i * kScreenWidth, 0, kScreenWidth, SCROLLVIEW_HEIGHT);
        vc.dataSource = self;
        [self.vcArray addObject:vc];
        
        [self.scrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(kScreenWidth* i , 0, kScreenWidth, SCROLLVIEW_HEIGHT);
        self.scrollView .contentOffset = CGPointMake(kScreenWidth*i, 0);
        self.scrollView .contentSize = CGSizeMake(titleArray.count*kScreenWidth, 0);
        
        
        
    }
    [menu setItems:titleArray selectedItemIndex:self.tabIndex];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
