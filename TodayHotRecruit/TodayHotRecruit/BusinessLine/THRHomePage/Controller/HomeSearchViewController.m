//
//  HomeSearchViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//  Result 另算 主体为collectionView

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) CustomSearch *searchBar;
@property (nonatomic, strong) UICollectionView *contentCollection;
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 navi
    [self setUpNavi];
    
    //设置collection
    [self.view addSubview:self.contentCollection];
}

-(void)setUpNavi{
    self.navBarItemView.backgroundColor = CommmonBlue;
    self.navBar.backgroundColor = CommmonBlue;
    
//    UITextField* searchField = [UITextField new];
//    searchField.backgroundColor = [UIColor whiteColor];
//    UIImageView* mirror = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
//    mirror.contentMode = UIViewContentModeCenter;
//    mirror.width = PXGet375Width(80);
//    searchField.leftView = mirror;
//    searchField.leftViewMode = UITextFieldViewModeUnlessEditing;
//    searchField.layer.cornerRadius = PXGet375Width(35);
//    [self.navBarItemView addSubview:searchField];
//
//    searchField.sd_layout
//    .centerYEqualToView(self.navBarItemView)
//    .heightRatioToView(self.navBarItemView, 0.8)
//    .centerXEqualToView(self.navBarItemView)
//    .leftSpaceToView(self.navBar.backButton, 0)
//    .rightSpaceToView(self.navBar.rightButton, 0);
//
//    self.navBar.rightButton.hidden = NO;
//    [self.navBar.rightButton setTitle:@"搜索" forState:UIControlStateNormal];
//    self.navBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    
    [self.navBarItemView addSubview:self.searchBar];
}

#pragma mark ---- lazy

- (CustomSearch *)searchBar {
    if (!_searchBar) {
        CustomSearch *searchBar = [[CustomSearch alloc] initWithFrame:CGRectMake(44, 0.f, kScreenWidth - 88, kSearchBarHeight)];
        searchBar.delegate = self;
        //searchBar.backgroundColor = RGBACOLOR(66, 164, 255, 1);
        //searchBar.placeholder = @"搜索城市名称/首字母缩写";
        
        //设置背景色
        UIImage* searchBarBg = [searchBar GetImageWithColor:CommmonBlue andHeight:kSearchBarHeight];
        
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

@end
