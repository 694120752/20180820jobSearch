//
//  HomePageViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//


//controller
#import "HomePageViewController.h"
#import "ZJCityViewController.h"

//view
#import "BaseTableView.h"

//cell
#import "BannerTableViewCell.h"
#import "IconTableViewCell.h"
#import "HomeJobTableViewCell.h"
#import "ScrollMessageTableViewCell.h"
#import "JobTableViewCell.h"


@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,THRCommonDelegate>

/** 主体tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

// 下面的工作数据
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self setUpNavi];
    
    
}

// 设置导航栏
- (void)setUpNavi{

    UIView* customNavi = [[UIView alloc]init];
    customNavi.frame = CGRectMake(0, 0, kScreenWidth, NavigationBar_Bottom_Y);
    
    //定位标签
//    UIImage* locationImage = [UIImage imageNamed:@"location"];
//    UIImageView* location = [[UIImageView alloc]initWithImage:locationImage];
    UIButton* location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    location.contentMode = UIViewContentModeCenter;
    location.frame = CGRectMake(10, 20, PXGet375Width(40), NavigationBar_Bottom_Y - 20);
    [location addTarget:self action:@selector(locationVC) forControlEvents:UIControlEventTouchUpInside];
    [customNavi addSubview:location];
    
    //签到
    UIButton* signButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signButton setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
    signButton.frame = CGRectMake(kScreenWidth - PXGet375Width(80) - 15, 20, PXGet375Width(80), NavigationBar_Bottom_Y - 20);
    signButton.contentMode = UIViewContentModeScaleAspectFill;
    [customNavi addSubview:signButton];
    
    //放大镜
    UIButton* mirror = [UIButton buttonWithType:UIButtonTypeCustom];
    mirror.frame = CGRectMake(signButton.mj_x - PXGet375Width(60) - 5 , 20, PXGet375Width(60), NavigationBar_Bottom_Y - 20);
    [mirror setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [customNavi addSubview:mirror];
    
    self.navBar.bottomLine.hidden = YES;
    
    [self.view addSubview:customNavi];
}


- (void)locationVC{
    ZJCityViewController* city = [[ZJCityViewController alloc]initWithDataArray:nil];
    [self.navigationController pushViewController:city animated:YES];
}

#pragma mark ---- iconSelectDelegate
- (void)selectIconWithIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

#pragma mark ---- tableViewDelegate && tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return 10;//self.dataArray.count;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //banner
                    BannerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BannerTableViewCell class])];
                    return cell;
                }
                    break;
                case 1:
                {
                    //icon
                    IconTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IconTableViewCell class])];
                    cell.delegate = self;
                    return cell;
                    
                }
                    break;
                case 2:
                {
                    //scroll
                    ScrollMessageTableViewCell* base = [[ScrollMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ScrollMessageTableViewCell class])];
                    return base;
                    
                }
                    break;
                default:{
                    BaseTableViewCell* base = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
                    return base;
                }
                    break;
            }
            
        }
            break;
        case 1:
        {
            //job
            JobTableViewCell* base = [[JobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
            return base;
        }
            break;
            
        default:{
            BaseTableViewCell* base = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
            return base;
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return [BannerTableViewCell cellHeight];
                }
                    break;
                case 1:
                {
                    return [IconTableViewCell selfHeight];
                }
                    break;
                case 2:
                {
                    return [ScrollMessageTableViewCell selfHeight];
                }
                    break;
                    
                default:{
                    return 0;
                }
                    break;
            }
        }
            break;
        case 1:
        {
            return [JobTableViewCell selfHeight];
        }
            break;
            
        default:{
            return 0;
        }
            break;
    }
}

#pragma mark ---- lazy

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BannerTableViewCell class])];
        [_tableView registerClass:[IconTableViewCell class] forCellReuseIdentifier:NSStringFromClass([IconTableViewCell class])];
        [_tableView registerClass:[HomeJobTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeJobTableViewCell class])];
        [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JobTableViewCell class])];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
