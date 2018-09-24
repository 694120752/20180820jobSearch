//
//  HomePageViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

//controller
#import "HomePageViewController.h"
#import "CityLocationViewController.h"
#import "HomeSearchViewController.h"
#import "ExclusiveConsultantViewController.h"
#import "TodayHotJobViewController.h"
#import "UnderLineStoreViewController.h"
#import "JobDetailViewController.h"

//view
#import "BaseTableView.h"

//cell
#import "BannerTableViewCell.h"
#import "IconTableViewCell.h"
#import "HomeJobTableViewCell.h"
#import "ScrollMessageTableViewCell.h"
#import "JobTableViewCell.h"

// 定位
#import <CoreLocation/CoreLocation.h>

// 网络请求
#import "THRRequestManager.h"
#import "THRJobListRequest.h"

// 工作obj
#import "THRJob.h"
#import "THRCompany.h"
#import "HomepageViewModel.h"

// MJ
#import <MJExtension.h>
#import <MJRefresh.h>




@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,THRCommonDelegate>

/** 主体tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

// 下面的工作数据
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 定位按钮*/
@property(nonatomic,strong)UIButton* locationButton;

/** 定位三件套*/
@property (strong, nonatomic) CLLocationManager *locManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

/** 页数*/
@property(nonatomic,assign)NSUInteger pageNo;

/** model*/
@property(nonatomic,strong)HomepageViewModel* viewModel;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self beginGetLocation];
    
    [self.view addSubview:self.tableView];
    
    [self setUpNavi];
    
    // 获取轮播数据
    [self GetBroCastData];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.pageNo = 1;
   
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
    //location.contentMode = UIViewContentModeCenter;
    _locationButton = location;
    location.frame = CGRectMake(25, 20, PXGet375Width(200), NavigationBar_Bottom_Y - 20);
    location.imageView.sd_layout.leftSpaceToView(location, 0);
    location.imageView.sd_layout.widthIs(PXGet375Width(25));
    location.imageView.sd_layout.heightIs(PXGet375Width(30));
    location.imageView.sd_layout.centerYEqualToView(location);
    
    location.titleLabel.sd_layout.leftSpaceToView(location.imageView, Get375Width(5));
    location.titleLabel.sd_layout.rightSpaceToView(location, 0);
    location.titleLabel.sd_layout.topSpaceToView(location, 0);
    location.titleLabel.sd_layout.bottomSpaceToView(location, 0);
    [location setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [location setTitle:@"正在定位" forState:UIControlStateNormal];
    _locationButton.titleLabel.textColor = [UIColor darkTextColor];
    _locationButton.titleLabel.font = font(PXGet375Width(27));
    [location addTarget:self action:@selector(locationVC) forControlEvents:UIControlEventTouchUpInside];
    [customNavi addSubview:location];
    
    //签到
    UIButton* signButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signButton setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
    signButton.frame = CGRectMake(kScreenWidth - PXGet375Width(80) - 15, 20, PXGet375Width(80), NavigationBar_Bottom_Y - 20);
    [signButton addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
    signButton.contentMode = UIViewContentModeScaleAspectFill;
    [customNavi addSubview:signButton];
    
    //放大镜
    UIButton* mirror = [UIButton buttonWithType:UIButtonTypeCustom];
    mirror.frame = CGRectMake(signButton.mj_x - PXGet375Width(60) - 5 , 20, PXGet375Width(60), NavigationBar_Bottom_Y - 20);
    [mirror setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [mirror addTarget:self action:@selector(searchVc) forControlEvents:UIControlEventTouchUpInside];
    [customNavi addSubview:mirror];
    
    self.navBar.bottomLine.hidden = YES;
    
    [self.view addSubview:customNavi];
}

#pragma mark -------------------------- 选完城市
- (void)locationVC{
    CityLocationViewController* city = [[CityLocationViewController alloc]initWithDataArray:nil];
    city.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf = self;
    [city setupCityCellClickHandler:^(NSString *title) {
       // NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];

        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        [weakSelf.locationButton setTitle:title forState:UIControlStateNormal];
        
    }];
    [self.navigationController pushViewController:city animated:YES];
}

- (void)searchVc{
    HomeSearchViewController* search = [[HomeSearchViewController alloc]init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}


#pragma mark -------------------- 签到
- (void)signAction{
    
//    THRRequestManager
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    UserDefault
    NSString* userName = @"";
    NSDictionary* dic = [ud objectForKey:@"userInfo"];
    if (NotNilAndNull(dic)) {
        userName = [dic objectForKey:@"userName"];
        [manager.requestSerializer setValue:userName forHTTPHeaderField:@"x-s-loginName"];
    }
    
    [manager GET:[HTTP stringByAppendingString:@"/signRecord/add"] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.userInteractionEnabled = NO;
        NSDictionary* result = responseObject;
        NSString* resultCode = @"";
        if (!IsStrEmpty([result objectForKey:@"desc"])) {
            resultCode = [result objectForKey:@"desc"];
            if ([resultCode isEqualToString:@"success"]) {
                UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                hud.customView = imageView;
                hud.mode = MBProgressHUDModeCustomView;
                hud.label.text = NSLocalizedString(@"签到成功", @"HUD completed title");
            }
        }else{
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"已经签到过", @"HUD completed title");
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"签到失败", @"HUD completed title");
    }];
}

#pragma mark ---- iconSelectDelegate
- (void)selectIconWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            TodayHotJobViewController* today = [[TodayHotJobViewController alloc]init];
            today.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:today animated:YES];
        }
            break;
            
        case 1:
        {
            UnderLineStoreViewController* line = [[UnderLineStoreViewController alloc]init];
            line.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:line animated:YES];
        }
            break;
            
        case 2:
        {
            ExclusiveConsultantViewController* ec = [ExclusiveConsultantViewController new];
            ec.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ec animated:YES];
        }
            break;
            
        default:
            break;
    }
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
            return self.dataArray.count ;
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
                    if (!self.viewModel.isUpdateMessageScroll) {
                        [base upDateData];
                        self.viewModel.isUpdateMessageScroll = YES;
                    }
                    
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
            base.job = self.dataArray[indexPath.row];
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


#pragma mark --------------- 获取用定位
// 开始定位
- (void)beginGetLocation {
    [self.locManager requestWhenInUseAuthorization];
    
    __weak typeof(self) weakSelf = self;
    [self.geocoder reverseGeocodeLocation:self.locManager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [weakSelf.locManager stopUpdatingLocation];
        if (error || placemarks.count == 0) {
            [weakSelf.locationButton setTitle:@"请手动选择" forState:UIControlStateNormal];
        }else{
            
            CLPlacemark *currentPlace = [placemarks firstObject];
            //weakSelf.locationCityName = currentPlace.locality;
            [weakSelf.locationButton setTitle:currentPlace.locality forState:UIControlStateNormal];
            
        }
//        [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(reloadLocationCity) userInfo:nil repeats:NO];
    }];
}


#pragma mark ------------- 获取轮播数据
- (void)GetBroCastData{
    THRRequestManager* manager = [THRRequestManager manager];
    [manager setDefaultHeader];
    __weak typeof(self)weakSelf = self;
    [manager POST:[HTTP stringByAppendingString:@"/banner/list"] parameters:@{@"title":@""} progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DESC
              if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
                  NSArray* dataArr = [resultDic objectForKey:@"dataList"];
                 BannerTableViewCell* cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                  
                  NSMutableArray* temp = [NSMutableArray array];
                  for (NSDictionary* dic in dataArr) {
                      NSString* url = EncodeStringFromDic(dic, @"coverRequestUrl");
                      
                      if (!IsStrEmpty(url)) {
                          [temp addObject:url];
                      }
                  }
                  [cell updateWithURL:[temp copy]];
              }
          } failure:nil];
   
}

#pragma mmark ------------------- 点击进入详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THRJob *job = self.dataArray[indexPath.row];
    JobDetailViewController *detail = [JobDetailViewController new];
    detail.jobId = job.id;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark ------------------ 获取首页的列表数据
- (void)getNewJobList{
    self.pageNo = 0;
    [self.tableView.mj_footer resetNoMoreData];
    [self.dataArray removeAllObjects];
    
     __weak typeof(self)weakSelf = self;
    [THRJobListRequest getJobDataWithPage:weakSelf.pageNo andTableView:weakSelf.tableView andSuccess:^(NSArray *dataList) {
        weakSelf.dataArray = [dataList mutableCopy];
        weakSelf.viewModel.isUpdateMessageScroll = NO;
    } andCityID:nil andKeyWord:nil];
}

- (void)getMoreJobList{
    self.pageNo ++;
    __weak typeof(self)weakSelf = self;
    [THRJobListRequest getJobDataWithPage:weakSelf.pageNo andTableView:weakSelf.tableView andSuccess:^(NSArray *dataList) {
        weakSelf.dataArray = [[weakSelf.dataArray arrayByAddingObjectsFromArray:dataList] mutableCopy];
    } andCityID:nil andKeyWord:nil];
}

#pragma mark ---- lazy

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE - 5)  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        __weak typeof(self)weakSelf = self;
        MJRefreshNormalHeader* normaleHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getNewJobList];
        }];
        normaleHeader.stateLabel.text = @"找工作正在刷新";
        _tableView.mj_header = normaleHeader;
        
        MJRefreshAutoNormalFooter* mjFoot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf getMoreJobList];
        }];
        mjFoot.automaticallyRefresh = NO;
        _tableView.mj_footer = mjFoot;
        _tableView.mj_footer.hidden = YES;
        
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

- (CLLocationManager *)locManager{
    if (!_locManager) {
        CLLocationManager *locManager = [CLLocationManager new];
        locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locManager.distanceFilter = kCLDistanceFilterNone;
        _locManager = locManager;
    }
    return _locManager;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(HomepageViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomepageViewModel alloc]init];
        _viewModel.isUpdateMessageScroll = NO;
    }
    return _viewModel;
}

@end
