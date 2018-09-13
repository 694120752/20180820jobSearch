//
//  NSString+zFundation.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (zFundation)


// 计算字体

- (CGSize)sizeWithFont:(UIFont *)font limitedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *    @brief    校验有效手机号
 *
 *
 *    @return    是否为有效手机号码
 */
- (BOOL)isPhoneNumber;
@end
