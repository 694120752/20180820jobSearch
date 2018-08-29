//
//  BaseNavigationBar.m
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseNavigationBar.h"

@implementation BaseNavigationBar

+ (BaseNavigationBar *)navigationBar{
    BaseNavigationBar* bar = [[BaseNavigationBar alloc]init];
    CGSize sz = [UIScreen mainScreen].bounds.size;
    bar.frame = CGRectMake(.0f, .0f, sz.width, 64.0f);
    return bar;
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
        _titleLabel.textColor = [UIColor colorWithRed:68/255.0f green:68/255.0f  blue:68/255.0f  alpha:1];
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

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

- (void)setUnreadLabelNeedWhiteBorder:(BOOL)needWhiteBorder {
    
}

@end
