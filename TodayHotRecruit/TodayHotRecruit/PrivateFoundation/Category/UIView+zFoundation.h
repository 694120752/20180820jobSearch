//
//  UIView+Foundation.h
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (zFoundation)


@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;


- (void)z_removeAllSubviews;
- (UIViewController *)z_viewController;


/**
 添加网格线

 @param view 要添加的View
 @param widthSize 竖线间距离
 @param heightSize 横线间距离
 @param lineColor 线的颜色
 */
- (void)addGrid:(UIView *)view withWidthSize:(CGFloat)widthSize andHeightSize:(CGFloat)heightSize andColor:(UIColor *)lineColor;

- (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
           cornerRadius:(CGFloat)cornerRadius
                  color:(UIColor *)shadowColor
           shadowOffset:(CGSize)offsetSize;
@end
