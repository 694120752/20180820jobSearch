//
//  BaseToast.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BaseToast : NSObject

/*
 * toast on top window
 * @xzoscar
 */

+ (void)toast:(NSString *)toastString;

/*
 * toast on top 'fromView'
 * @xzoscar
 */

+ (void)toast:(NSString *)toastString view:(UIView *)fromView;

/*
 * toast on top window
 * @xzoscar
 */
+ (void)toastSuccess:(NSString *)toastString;

/*
 * toast on top 'fromView'
 * @xzoscar
 */

+ (void)toastSuccess:(NSString *)toastString view:(UIView *)fromView;

/*
 * hide Toast
 * You do not need call this function!
 * @xzoscar
 */
+ (void)hideToast;

@end

