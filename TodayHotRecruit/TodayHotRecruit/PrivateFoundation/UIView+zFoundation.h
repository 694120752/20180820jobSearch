//
//  UIView+Foundation.h
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (zFoundation)
- (void)z_removeAllSubviews;
- (UIViewController *)z_viewController;
- (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
           cornerRadius:(CGFloat)cornerRadius
                  color:(UIColor *)shadowColor
           shadowOffset:(CGSize)offsetSize;
@end
