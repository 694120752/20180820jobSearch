//
//  HomeSearchViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//  Result 另算 主体为collectionView

#import "HomeSearchViewController.h"
#import "UILabel+zFundation.h"
#import "THRRequestManager.h"
#import "TodayChildVcViewController.h"

@interface HomeSearchViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) CustomSearch *searchBar;
@property (nonatomic, strong) UICollectionView *contentCollection;
/** dataArray*/
@property(nonatomic,strong)NSMutableArray* dataArray;
@end


@implementation SearchItem 
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.contentLabel = [UILabel new];
    [self.contentView addSubview:self.contentLabel];
    //CGRectMake(0, 0, PXGet375Width(100), PXGet375Width(40));
    self.contentLabel.frame = CGRectMake(0, 0, PXGet375Width(120), PXGet375Width(50));//self.contentView.bounds;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.contentLabel.text = EncodeStringFromDic(dic, @"searchKey");
}
@end
@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 navi
    [self setUpNavi];
    
    //热门搜索
    [self.view addSubview:self.contentCollection];
    
    // 获取热门搜索
    
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/searchHistory/list"] parameters:@{@"pageSize":@"10"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.dataArray = [responseObject objectForKey:@"dataList"];
        [weakSelf.contentCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    
    self.navBar.rightButton.hidden = NO;
    [self.navBar.rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    self.navBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    [self.navBar.rightButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarItemView addSubview:self.searchBar];
    
    UILabel* hotLabel = [UILabel new];
    hotLabel.frame = CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, PXGet375Width(100));
    hotLabel.text = @"热门搜索";
    hotLabel.yf_contentInsets = UIEdgeInsetsMake(0, PXGet375Width(20), 0, 0);
    [self.view addSubview:hotLabel];
}


#pragma mark --------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItem* item = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchItem" forIndexPath:indexPath];
    item.dic = self.dataArray[indexPath.row];
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(PXGet375Width(120), PXGet375Width(50));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = self.dataArray[indexPath.row];
    
    TodayChildVcViewController* list = [[TodayChildVcViewController alloc]initWithKeyWord:EncodeStringFromDic(dic, @"searchKey")];
    
    [self.navigationController pushViewController:list animated:YES];
}

- (void)searchAction{
    if (IsStrEmpty(self.searchBar.text)) {
        return;
    }
    TodayChildVcViewController* list = [[TodayChildVcViewController alloc]initWithKeyWord:self.searchBar.text];
    
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark ---- lazy

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
        [searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
       
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (UICollectionView *)contentCollection{
    if (!_contentCollection) {
        _contentCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - PXGet375Width(100)) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _contentCollection.delegate = self;
        _contentCollection.dataSource = self;
        _contentCollection.backgroundColor = RGBACOLOR(240, 240, 240, 1);
        [_contentCollection registerClass:[SearchItem class] forCellWithReuseIdentifier:@"SearchItem"];
    }
    return  _contentCollection;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
