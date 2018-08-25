//
//  BaseNavigationBar.h
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseNavigationBar : UIView

@property (nonatomic,strong) UIView   *barItem;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UIView   *bottomLine;

@property (nonatomic,strong) UIView   *unreadLabel;

+ (BaseNavigationBar *)navigationBar;

- (void)setUnreadLabelNeedWhiteBorder:(BOOL)needWhiteBorder;

@end
