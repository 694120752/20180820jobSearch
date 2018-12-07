//
//  BaseNavigationBar.m
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseNavigationBar.h"
@interface BaseNavigationBar ()
//self.searchViewUpglideFrame = upglideFrame;

@property (nonatomic, assign) CGRect searchViewUpglideFrame;

@property (nonatomic, assign) CGRect searchViewBeginFrame;

// 滑动状态标识
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation BaseNavigationBar

+ (BaseNavigationBar *)navigationBar{
    BaseNavigationBar* bar = [[BaseNavigationBar alloc]init];
    CGSize sz = [UIScreen mainScreen].bounds.size;
    bar.frame = CGRectMake(.0f, .0f, sz.width, 64.0f);
    return bar;
}

+ (BaseNavigationBar *)searchViewNavigationBar
{
    BaseNavigationBar *bar = [[BaseNavigationBar alloc] initWithSearchView];
    bar.frame = CGRectMake(.0f,.0f, kScreenWidth, 64.0f);
    return bar;
}

// 大导航栏：带标题和滑动搜索框
+ (BaseNavigationBar *)navigationBarWithTitleAndSearchView
{
    BaseNavigationBar *bar = [[BaseNavigationBar alloc] initWithTitleAndSearchView];
    
    bar.frame = CGRectMake(.0f,.0f, kScreenWidth, 106.f);
    return bar;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _isAnimating = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.barItem addSubview:self.backButton];
        [self.barItem addSubview:self.titleLabel];
        [self.barItem addSubview:self.rightButton];
        
        [self.barItem addSubview:self.unreadLabel];
        
        [self addSubview:self.barItem];
        [self addSubview:self.bottomLine];
        
    }
    return self;
}


- (id)initWithTitleAndSearchView
{
    if (self = [super init])
    {
        self.barItem.height = 86;
        self.searchView.frame = CGRectMake(12, 50, kScreenWidth-24, 30);
        [self.barItem addSubview:self.searchView];
        
        self.searchLabel.width = self.searchView.width-72;
        self.searchRightView.left = self.searchView.width-30;
        self.bottomLine.top = 63.5;
        
    }
    return self;
}

- (id)initWithSearchView
{
    if (self = [super init])
    {
        [self.barItem addSubview:self.searchView];
    }
    return self;
}

// 上滑
- (void)searchViewUpglide:(CGRect)upglideFrame animate:(BOOL)animate completed:(void (^)(void))completed{
    
    if (!_isAnimating && self.searchView.top == 50) {
        self.searchViewUpglideFrame = upglideFrame;
        self.searchViewBeginFrame = self.searchView.frame;
        
        [self.barItem bringSubviewToFront:self.searchView];
        self.height = Top_iPhoneX_SPACE + 64;
        self.barItem.height = 44;
        self.bottomLine.top = self.height - 0.5;
        [UIView animateWithDuration:0.25 animations:^{
            self.searchView.frame = upglideFrame;
            self.searchRightView.left = self.searchView.width - 30;
            self.searchLabel.width = self.searchView.width-(self.searchRightView.hidden?48:72);
        } completion:^(BOOL finished) {
            if (completed) {
                completed();
            }
        }];
        
    }
}



// 下滑
- (void)searchViewGlide:(BOOL)animate completed:(void (^)(void))completed{
    if (!_isAnimating && self.searchView.top == self.searchViewUpglideFrame.origin.y)
    {
        _isAnimating = YES;
        self.height = Top_iPhoneX_SPACE + 106;
        self.barItem.height = 86;
        self.bottomLine.top = self.height - 0.5;
        [UIView animateWithDuration:0.3 animations:^{
            self.searchView.frame = self.searchViewBeginFrame;
            self.searchRightView.left = self.searchView.width - 30;
            self.searchLabel.width = self.searchView.width-(self.searchRightView.hidden?48:72);
            
        } completion:^(BOOL finished) {
            
            self->_isAnimating = NO;
            if (completed)
            {
                completed();
            }
        }];
    }
}

- (UIButton *)backButton {
    if (nil == _backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(.0f,.0f,44.0f,44.0f)];
        [_backButton setImage:[UIImage imageNamed:@"backArrow"]
                     forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"backArrow"]
                     forState:UIControlStateHighlighted];
        _backButton.accessibilityLabel = @"返回";
    }
    return _backButton;
}

- (UIButton *)rightButton {
    if (nil == _rightButton) {
        CGSize sz = [UIScreen mainScreen].bounds.size;
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(sz.width-44.0f,.0f,44.0f,44.0f)];
        [_rightButton setImage:[UIImage imageNamed:@"更多图片"]
                      forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"更多图片"]
                      forState:UIControlStateHighlighted];
        _rightButton.accessibilityLabel = @"打开下拉菜单";
    }
    return _rightButton;
}

- (UIView *)unreadLabel {
    if (nil == _unreadLabel) {
        CGSize sz = [UIScreen mainScreen].bounds.size;
        _unreadLabel = [[UIView alloc] init];
        _unreadLabel.frame = CGRectMake(sz.width-16.0f,6.0f,8.0f,8.0f);
        _unreadLabel.backgroundColor = [UIColor colorWithRed:248/255.0f green:5/255.0f blue:49/255.0f
                                                       alpha:1.0f];
        _unreadLabel.layer.cornerRadius = 4.0f;
        _unreadLabel.hidden = YES;
    }
    return _unreadLabel;
}

- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        CGSize sz = [UIScreen mainScreen].bounds.size;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(44.0f,.0f,sz.width-88.0f,44.0f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:68/255.0f green:68/255.0f  blue:68/255.0f  alpha:1];
        _titleLabel.font      = [UIFont systemFontOfSize:17.0f];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UIView *)barItem {
    if (nil == _barItem) {
        CGSize sz = [UIScreen mainScreen].bounds.size;
        _barItem = [[UIView alloc] initWithFrame:CGRectMake(.0f,20.0f,sz.width,44.0f)];
        _barItem.backgroundColor = [UIColor whiteColor];
    }
    return _barItem;
}

- (UIView *)bottomLine {
    if (nil == _bottomLine) {
        CGSize sz   = [UIScreen mainScreen].bounds.size;
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(.0f,63.5f,sz.width,0.5)];
        UIColor *color = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
        _bottomLine.backgroundColor = color;
    }
    return _bottomLine;
}


/*
 搜索背景图
 */
- (UIImageView *)searchView
{
    if (!_searchView)
    {
        _searchView = [[UIImageView alloc] initWithFrame:CGRectMake(self.backButton.right+9, 7, kScreenWidth-102, 30)];

        UIImage *bgImage = [UIImage imageNamed:@""];
        _searchView.backgroundColor = RANDOMCOLOR;
        // 图片拉伸控制左右的剩余部分 剩下的拉伸
        _searchView.image = [bgImage stretchableImageWithLeftCapWidth:22.5 topCapHeight:15];

        // 搜索图片上的控件
        [_searchView addSubview:self.searchIconView];
        [_searchView addSubview:self.searchLabel];
        [_searchView addSubview:self.searchRightView];
    }
    return _searchView;
}

/*
 搜索icon
 */
- (UIImageView *)searchIconView
{
    if (!_searchIconView)
    {
        _searchIconView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 6, 18, 18)];
//        _searchIconView.image = [UIImage imageNamed:[self getNavImageNameWithType:NavImageType_Search_Icon]];
    }
    return _searchIconView;
}

/*
 搜索文字
 */
- (UILabel *)searchLabel
{
    if (!_searchLabel)
    {
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.searchIconView.right+6, 6, self.searchView.width-72, 18)];
        _searchLabel.text = @"";
        _searchLabel.font = [UIFont systemFontOfSize:13];
        _searchLabel.backgroundColor = [UIColor clearColor];
    }
    return _searchLabel;
}

/*
 相机按钮
 */
- (UIButton *)searchRightView
{
    if (!_searchRightView)
    {
        _searchRightView = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchRightView.frame = CGRectMake(self.searchView.width-30, 6, 18, 18);
        //CustomImage
//        [_searchRightView setImage:[UIImage imageNamed:[self getNavImageNameWithType:NavImageType_Search_Camera]] forState:UIControlStateNormal];
//        [_searchRightView setImage:[UIImage imageNamed:[self getNavImageNameWithType:NavImageType_Search_Camera]] forState:UIControlStateHighlighted];
    }
    return _searchRightView;
}



@end
