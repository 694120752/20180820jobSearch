//
//  ViewController.m
//  ZJIndexcitys
//
//  Created by ZeroJ on 16/10/10.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "CityLocationViewController.h"
#import "ZJCity.h"
#import "ZJSearchResultController.h"
#import "ZJProgressHUD.h"
#import "ZJCitiesGroup.h"
#import "ZJCityTableViewCell.h"
#import "ZJLocationCityTableViewCell.h"
#import "NSDictionary+zFundation.h"

#import "THRRequestManager.h"
#import "BaseToast.h"

#import <CoreLocation/CoreLocation.h>


@interface CityLocationViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate> {
    NSArray<ZJCitiesGroup *> *_data;
    NSMutableDictionary *cellsHeight;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CustomSearch *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray<ZJCity *> *allData;
@property (copy, nonatomic) ZJCitySelectedHandler citySelectedHandler;
@property (assign, nonatomic) ZJCityLocationState locationState;
@property (strong, nonatomic) CLLocationManager *locManager;//获取用户位置
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (copy, nonatomic) NSString *locationCityName;

// sectionHeader
@property (nonatomic, strong) UIView *headerView;


@end


static NSString *const kHotCellId = @"kHotCellId";
static NSString *const kNormalCellId = @"kNormalCellId";
static NSString *const kLocationCellId = @"kLocationCellId";

@implementation CitySearch
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    for (UIView* subView in self.subviews) {
//        for (UIView* ssubView in subView.subviews) {
//            if ([ssubView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
//                ssubView.layer.cornerRadius = PXGet375Width(35);
//                ssubView.clipsToBounds  = YES;
//            }
//        }
//    }
//}
@end


@implementation CityLocationViewController

- (instancetype)initWithDataArray:(NSArray<ZJCitiesGroup *> *)dataArray {
    if (self = [super initWithNibName:nil bundle:nil]) {
         [self setupData];
    }
    return self;
}

- (void)viewDidLoad {
    cellsHeight = [NSMutableDictionary dictionary];
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setUpNavi];
    
    [self.navBarItemView addSubview:self.searchBar];
    [self beginGetLocation];
    
}

- (void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backButton.hidden = NO;
}

-(void)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

// 开始定位
- (void)beginGetLocation {
    [self.locManager requestWhenInUseAuthorization];
    
    __weak typeof(self) weakSelf = self;
    [self.geocoder reverseGeocodeLocation:self.locManager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [weakSelf.locManager stopUpdatingLocation];
        if (error || placemarks.count == 0) {
            weakSelf.locationState = ZJCityLocationStateLocationFail;
        }else{
            weakSelf.locationState = ZJCityLocationStateLocationSuccess;

            CLPlacemark *currentPlace = [placemarks firstObject];
            weakSelf.locationCityName = currentPlace.locality;
        }
        [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(reloadLocationCity) userInfo:nil repeats:NO];
    }];
}



#pragma mark ------------------------------- 处理城市数据
// 初始化数据
- (void)setupData {
    
    UserDefault
    NSDictionary* dic = [ud objectForKey:@"userInfo"];
    if (!NotNilAndNull(dic)) {
        [BaseToast toast:@"请登录后操作"];
        return;
    }
    
    NSString* userName = [dic objectForKey:@"userName"];
    if (IsStrEmpty(userName)) {
        [BaseToast toast:@"请重新登录"];
        return;
    }
    
    THRRequestManager* manager = [THRRequestManager manager];
    manager.headerDic = @{@"x-s-loginName":userName};
    __weak typeof(self)weakSelf = self;
    [manager POST:[HTTP stringByAppendingString:@"/address/list"] parameters:@{@"level":@"2",@"parentID":@"",@"parentName":@""} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        NSMutableArray* allCity = [NSMutableArray array];
        
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            NSArray* cityArr = [resultDic objectForKey:@"dataList"];
            for (NSDictionary* dict in cityArr) {
                @autoreleasepool {
                    ZJCity* city = [ZJCity new];
                    city.name = EncodeStringFromDic(dict, @"name");
                    city.addressID = EncodeStringFromDic(dict, @"addressID");
                    [allCity addObject:city];
                }
            }
            
            [allCity sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                
                ZJCity * c1 = obj1;
                ZJCity* c2 = obj2;
                return [c1.firstLetter compare:c2.firstLetter options:NSNumericSearch];
            }];
            
//            把这个数组转换成 二位的
            NSMutableArray* tempArray = [NSMutableArray array];
            if (!IsArrEmpty(allCity)) {
                
                NSString* lastMark = @"";
                NSUInteger j = -1;
                
                for (NSUInteger i = 0; i< allCity.count; i++) {
                    ZJCity* city = allCity[i];
                    NSString* compareMark = city.firstLetter;
                    if (![lastMark isEqualToString:compareMark]) {
//                        NSMutableDictionary* mDic = [NSMutableDictionary dictionary];
                        ZJCitiesGroup* group = [ZJCitiesGroup new];
                        group.cities = @[city];
                        group.indexTitle = compareMark;
//                        NSMutableArray* cities = [NSMutableArray array];
//                        [cities addObject:city.name];
//                        [mDic setValue:cities forKey:@"cities"];
//                        [mDic setValue:compareMark forKey:@"title"];
                        
                        [tempArray addObject:group];
                        lastMark = [compareMark copy];
                        j++;
                    }else{
                        // 取出来加进去
                        ZJCitiesGroup* group = tempArray[j];
                        NSMutableArray* temp = [group.cities mutableCopy];//[group objectForKey:@"cities"];
                        [temp addObject:city];
                        group.cities = [temp copy];
//                        [dict setValue:temp forKey:@"cities"];
                    }
                    
                }
            }
            
            // 添加热门城市
            ZJCity* city = [ZJCity new];
            city.name = @"北京";
            ZJCitiesGroup* hot = [ZJCitiesGroup new];
            hot.cities = @[city];
            hot.indexTitle = @"热门城市";
            
            [tempArray insertObject:hot atIndex:0];
            
            self->_data = tempArray;
            [weakSelf.tableView reloadData];
        }else{
            [BaseToast toast:desc];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"地址出错咯"];
    }];
//    for (NSDictionary *citisDic in rootArray) {
//        ZJCitiesGroup *citiesGroup = [[ZJCitiesGroup alloc] initWithDictionary:citisDic];
//        [tempArray addObject:citiesGroup];
//    }
//    _data = tempArray;
}

// 刷新定位城市的section == 0
- (void)reloadLocationCity {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

// 设置点击响应block
- (void)setupCityCellClickHandler:(ZJCitySelectedHandler)citySelectedHandler {
    _citySelectedHandler = [citySelectedHandler copy];
}
// 选中了城市的响应方法
// 三个地方需要调用: 点击了 热门城市 /搜索城市 /普通的城市
- (void)cityDidSelected:(NSString *)title {
    if (_citySelectedHandler) {
        _citySelectedHandler(title);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _data.count + 1; // +1 作为定位城市
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    ZJCitiesGroup *citiesGroup = _data[section-1];

    return citiesGroup.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        ZJLocationCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationCellId];
        __weak typeof(self) weakSelf = self;
        [cell setupCellWithLocationState:self.locationState locationCityName:self.locationCityName cityClickHandler:^(NSString *title) {
            [weakSelf cityDidSelected:title];
        }];
        return cell;

    }
    else if (indexPath.section == 1) {
        ZJCitiesGroup *citiesGroup = _data[indexPath.section-1];
        
        ZJCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotCellId];
        cell.citiesGroup = citiesGroup;
        __weak typeof(self) weakSelf = self;
        [cell setupCityCellClickHandler:^(NSString *title) {
            [weakSelf cityDidSelected:title];
        }];
        [cellsHeight setValue:[NSNumber numberWithFloat:cell.cellHeight] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
        cell.backgroundColor = RGBACOLOR(245, 245, 245, 1);
        return cell;
    }
    else {
        ZJCitiesGroup *citiesGroup = _data[indexPath.section-1];
        ZJCity *city = citiesGroup.cities[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellId];
 
        cell.textLabel.text = city.name;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (cellsHeight.count == 0) {
            return 0;
        }
        return [[cellsHeight valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]] floatValue];
    }
    else {
        return 44.f;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"定位城市";
    }
    ZJCitiesGroup *citiesGroup = _data[section-1];
    return citiesGroup.indexTitle;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 || indexPath.section==1) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZJCitiesGroup *citiesGroup = _data[indexPath.section-1];
    ZJCity *city = citiesGroup.cities[indexPath.row];
    [self cityDidSelected:city.name];

}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:_data.count];
    for (ZJCitiesGroup *citiesGroup in _data) {
        [indexTitles addObject:citiesGroup.indexTitle];
    }
    indexTitles[0] = @"";
    return indexTitles;
}

// 可以相应点击的某个索引, 也可以为索引指定其对应的特定的section, 默认是 section == index
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [ZJProgressHUD showStatus:title andAutoHideAfterTime:0.5];
    
    return index+1;
}


#pragma mark -----------------------------------  UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (searchBar == self.searchBar) {
        [self presentViewController:self.searchController animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar == _searchController.searchBar) {
        ZJSearchResultController *resultController = (ZJSearchResultController *)_searchController.searchResultsController;
        // 更新数据 并且刷新数据
        resultController.data = [ZJCity searchText:searchText inDataArray:self.allData];
    }
}


// 这个代理方法在searchController消失的时候调用, 这里我们只是移除了searchController, 当然你可以进行其他的操作
- (void)didDismissSearchController:(UISearchController *)searchController {
    // 销毁
    self.searchController = nil;
}

#pragma mark ------------------------------------ End

- (UISearchController *)searchController {
    if (!_searchController) {
        ZJSearchResultController *resultController = [ZJSearchResultController new];
        __weak typeof(self) weakSelf = self;
        [resultController setupCityCellClickHandler:^(NSString *title) {
            // 设置选中城市
            [weakSelf cityDidSelected:title];
            // dismiss
            [weakSelf.searchController dismissViewControllerAnimated:YES completion:nil];
            // 置为nil 销毁
            weakSelf.searchController = nil;
        }];
        // ios8+才可用 否则使用 UISearchDisplayController
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
        
        searchController.delegate = self;
        searchController.searchBar.delegate = self;
        searchController.searchBar.placeholder = @"搜索城市名称/首字母缩写";
        _searchController = searchController;
    }
    return _searchController;
}

- (NSArray<ZJCity *> *)allData {
    NSMutableArray<ZJCity *> *allData = [NSMutableArray array];
    int index = 0;
    for (ZJCitiesGroup *citysGroup in _data) {// 获取所有的city
        if (index == 0) {// 第一组, 热门城市忽略
            index++;
            continue;
        }
        if (citysGroup.cities.count != 0) {
            for (ZJCity *city in citysGroup.cities) {
                [allData addObject:city];
            }
        }
        index++;
    }
    return allData;
}

- (CustomSearch *)searchBar {
    if (!_searchBar) {
        CustomSearch *searchBar = [[CustomSearch alloc] initWithFrame:CGRectMake(44, 0.f, kScreenWidth - 88, kSearchBarHeight)];
        searchBar.delegate = self;
        //searchBar.backgroundColor = RGBACOLOR(66, 164, 255, 1);
        //searchBar.placeholder = @"搜索城市名称/首字母缩写";
        
        //设置背景色
        UIImage* searchBarBg = [searchBar GetImageWithColor:CommonBlue andHeight:kSearchBarHeight];
        
        //设置背景图片
        [searchBar setBackgroundImage:searchBarBg];
        //设置背景色
        [searchBar setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        //[searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        
        [searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //[searchBar setSearchFieldBackgroundImage:[self GetImageWithColor:[UIColor whiteColor] andHeight:kSearchBarHeight] forState:UIControlStateNormal];
       // [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchField"] forState:UIControlStateNormal];
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        // 注册cell
        [tableView registerClass:[ZJCityTableViewCell class] forCellReuseIdentifier:kHotCellId];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNormalCellId];
        [tableView registerClass:[ZJLocationCityTableViewCell class] forCellReuseIdentifier:kLocationCellId];

        // 行高度
        tableView.rowHeight = 44.f;
        // sectionHeader 的高度  这边放到naviController 上面
        tableView.sectionHeaderHeight = PXGet375Width(80);
        tableView.tableHeaderView = self.headerView;
        // sectionIndexBar上的文字的颜色
        tableView.sectionIndexColor = [UIColor lightGrayColor];
        // 普通状态的sectionIndexBar的背景颜色
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        // 选中sectionIndexBar的时候的背景颜色
//        tableView.sectionIndexTrackingBackgroundColor = [UIColor yellowColor];
        _tableView = tableView;
    }
    return _tableView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, PXGet375Width(80));
        UILabel* titleContent = [UILabel new];
        // useDefault 中取上一次的
        NSUserDefaults* uf = [NSUserDefaults standardUserDefaults];
        NSString* st = [uf stringForKey:@"recentLocation"]?:@"最近无定位";
        titleContent.text = st;
        [_headerView addSubview:titleContent];
        
        titleContent.sd_layout
        .leftSpaceToView(_headerView, PXGet375Width(40))
        .topSpaceToView(_headerView, 0)
        .bottomSpaceToView(_headerView, 0)
        .rightSpaceToView(_headerView, 0);
        
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
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
@end


