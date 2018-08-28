//
//  BaseViewController.m
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
@private
    BOOL _isAnimatedWhenPopOrDismiss; // animated flag when pop or dismiss,default YES
    BOOL _isNavBarHidden; // default NO,是否隐藏导航栏
    BOOL _isNavBackItemHidden; // default NO,是否隐藏导航栏 返回按钮
    BOOL _isNavRightItemHidden; // default YES,是否隐藏导航栏 右侧更多按钮
    UIStatusBarStyle _statusBarStyle;
}

@property (nonatomic,strong) BaseNavigationBar *mNavBar;
@property (nonatomic,strong) NSString        *titleString;

// 导航栏返回按钮
@property (nonatomic,strong) UIButton *navBackBT;
@end

@implementation BaseViewController
- (void)dealloc {
#if DEBUG
    NSLog(@"dealloc: %@",self);
#endif
}

#ifdef __IPHONE_11_0
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    self.navBar.height = self.view.safeAreaInsets.top+44;
    self.navBar.barItem.top = self.view.safeAreaInsets.top;
    self.navBar.bottomLine.top = self.navBar.bottom-0.5f;
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    self.view.backgroundColor = color;
    
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.mNavBar];
    
    [self setNavBarHidden:_isNavBarHidden];
    [self setNavBarBackItemHidden:_isNavBackItemHidden];
    [self setNavBarRightItemHidden:_isNavRightItemHidden];
    
    self.mNavBar.titleLabel.text = _titleString;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 系统侧滑使能
    self.navigationController.interactivePopGestureRecognizer.enabled = !_closePopGestureRecognizer;
}

- (UIButton *)navBackBT {
    if (nil == _navBackBT) {
        _navBackBT = [[UIButton alloc] initWithFrame:CGRectMake(.0,.0,54.0,44)];
        _navBackBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _navBackBT.contentEdgeInsets = UIEdgeInsetsMake(.0,-7.0f,.0f,.0f);
        [_navBackBT setImage:[UIImage imageNamed:@"返回图片"] forState:UIControlStateNormal];
        [_navBackBT setImage:[UIImage imageNamed:@"高亮返回图片"] forState:UIControlStateHighlighted];
        [_navBackBT addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBackBT;
}

- (id)init {
    if (self = [super init]) {
        //self.hidesBottomBarWhenPushed = YES;
        _isAnimatedWhenPopOrDismiss   = YES;
        _isNavBarHidden               = NO;
        _isNavBackItemHidden          = NO;
        _isNavRightItemHidden         = YES;
        _statusBarStyle               = UIStatusBarStyleDefault;
        // 强制隐藏系统导航栏
        self.navigationController.navigationBarHidden = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

-(void)onBack:(id)sender{
    NSArray *vcs = self.navigationController.viewControllers;
    if (vcs.count > 1 && [vcs objectAtIndex:vcs.count-1] == self) {
        // View is disappearing because a new view controller was pushed onto the stack
        [self.navigationController popViewControllerAnimated:_isAnimatedWhenPopOrDismiss];
    }else {
        [self dismissViewControllerAnimated:_isAnimatedWhenPopOrDismiss completion:nil];
    }
}

-(BaseNavigationBar *)mNavBar{
    if (nil == _mNavBar) {
        _mNavBar = [BaseNavigationBar navigationBar];
        [_mNavBar.backButton addTarget:self
                                action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
        [_mNavBar.rightButton addTarget:self
                                 action:@selector(onNavRightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mNavBar;
}

- (UIView *)navBarItemView {
    return self.mNavBar.barItem;
}

- (BaseNavigationBar *)navBar {
    return self.mNavBar;
}

- (NSString *)title {
    return _titleString;
}

- (void)setTitle:(NSString *)title {
    _titleString = title;
    _mNavBar.titleLabel.text = _titleString;
}

// 导航栏右侧更多按钮
- (void)onNavRightItemClicked:(id)sender {
}

//pop或者右滑返回后做的事
- (void)popOrSlideRightToForeVC{
}

//捕捉系统右滑事件
-(void)didMoveToParentViewController:(UIViewController *)parent
{
    if (nil == parent) {//右滑或pop返回
        [self popOrSlideRightToForeVC];
    }
    [super didMoveToParentViewController:parent];
}

// 设置animate flg when pop or dismiss
- (void)setNavBackAnimated:(BOOL)flag {
    _isAnimatedWhenPopOrDismiss = flag;
}

- (void)setNavBackImage:(UIImage *)normalImage
            highlighted:(UIImage *)hlImage {
    [_mNavBar.backButton setImage:normalImage
                         forState:UIControlStateNormal];
    [_mNavBar.backButton setImage:hlImage
                         forState:UIControlStateHighlighted];
}

// 设置导航栏返回按钮隐藏
- (void)setNavBarBackItemHidden:(BOOL)bHidden {
    _isNavBackItemHidden = bHidden;
    _mNavBar.backButton.hidden = _isNavBackItemHidden;
}

// 设置导航栏隐藏
- (void)setNavBarHidden:(BOOL)bHidden {
    _isNavBarHidden = bHidden;
    
    // 自定义导航栏
    _mNavBar.hidden = _isNavBarHidden;
}

// 设置导航栏右侧按钮隐藏(更多)
- (void)setNavBarRightItemHidden:(BOOL)bHidden {
    _isNavRightItemHidden = bHidden;
    _mNavBar.rightButton.hidden = _isNavRightItemHidden;
    if (bHidden) {
        [self setNavBarUnReadViewHiden:YES];
    }
}

/**
 设置导航栏未读消息隐藏
 
 @param hiden 是否隐藏
 */
-(void)setNavBarUnReadViewHiden:(BOOL)hiden {
    if (_mNavBar.rightButton.hidden) {
        _mNavBar.unreadLabel.hidden = YES;
    } else {
        _mNavBar.unreadLabel.hidden = hiden;
    }
}

/*
 * 设置状态栏
 */
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    if (_statusBarStyle != [UIApplication sharedApplication].statusBarStyle) {
        [UIApplication sharedApplication].statusBarStyle = _statusBarStyle;
    }
}

// 获取状态栏样式
- (UIStatusBarStyle)statusBarStyle {
    return _statusBarStyle;
}

@end
