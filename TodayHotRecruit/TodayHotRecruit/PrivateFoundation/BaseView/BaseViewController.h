//
//  BaseViewController.h
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationBar.h"
@interface BaseViewController : UIViewController

/*
 * [44-titleView-44]
 */
@property (nonatomic,strong,readonly) UIView *navBarItemView;

// 由此改变自定义导航栏的默认属性
@property (nonatomic,strong,readonly) BaseNavigationBar *navBar;

// 关闭系统侧滑pop default NO
@property (nonatomic,assign) BOOL closePopGestureRecognizer;

- (void)onBack:(id)sender;

// 导航栏右侧更多按钮响应函数
- (void)onNavRightItemClicked:(id)sender;

#pragma mark -- 配置函数

// 重写系统setTitle
- (void)setTitle:(NSString *)title;

// 设置animate flg when pop or dismiss
- (void)setNavBackAnimated:(BOOL)flag;

// 设置导航栏返回按钮隐藏
- (void)setNavBarBackItemHidden:(BOOL)bHidden;

// 设置导航栏右侧按钮隐藏(更多)
- (void)setNavBarRightItemHidden:(BOOL)bHidden;

/**
 设置导航栏未读消息隐藏
 
 @param hiden 是否隐藏
 */
-(void)setNavBarUnReadViewHiden:(BOOL)hiden;

// 设置导航栏隐藏
- (void)setNavBarHidden:(BOOL)bHidden;

/*
 * 设置返回按钮图片
 * @para normalImage 正常状态image
 * @para hlImage     高亮状态image
 */
- (void)setNavBackImage:(UIImage *)normalImage
            highlighted:(UIImage *)hlImage;

// 设置状态栏
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

// 获取状态栏样式
- (UIStatusBarStyle)statusBarStyle;

//pop或者右滑返回后做的事
- (void)popOrSlideRightToForeVC;

// 替换导航栏
- (void)replaceNavBar:(BaseNavigationBar *)navBar;
@end
