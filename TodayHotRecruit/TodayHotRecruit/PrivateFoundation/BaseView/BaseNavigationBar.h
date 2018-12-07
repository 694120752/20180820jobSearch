//
//  BaseNavigationBar.h
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTitleLabel, CustomNavBackButton;

@interface BaseNavigationBar : UIView

@property (nonatomic,strong) UIView   *barItem;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UIView   *bottomLine;
@property (nonatomic,strong) UIView   *unreadLabel;

/*
 搜索右侧图
 */
@property (nonatomic, strong) UIButton *searchRightView;

/*
 搜索词
 */
@property (nonatomic, strong) UILabel *searchLabel;

/*
 搜索框左侧icon
 */
@property (nonatomic, strong) UIImageView *searchIconView;


/*
 搜索框背景
 */
@property (nonatomic, strong) UIImageView *searchView;


/*
 搜索词点击回调
 */
@property (nonatomic, copy) void (^searchTouchBlock)(NSString *searchText);


// 默认导航栏
+ (BaseNavigationBar *)navigationBar;

// 带搜索框的导航栏
+ (BaseNavigationBar *)searchViewNavigationBar;

// 大导航栏：带标题和滑动搜索框
+ (BaseNavigationBar *)navigationBarWithTitleAndSearchView;

/*
 搜索框上滑
 
 @param upglideFrame 搜索框上滑后的frame
 */
- (void)searchViewUpglide:(CGRect)upglideFrame animate:(BOOL)animate completed:(void(^)(void))completed;


/**
 搜索框下滑

 @param animate 动画
 @param completed 结束后回调
 */
- (void)searchViewGlide:(BOOL)animate completed:(void(^)(void))completed;

@end
