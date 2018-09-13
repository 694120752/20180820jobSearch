//
//  NSString+zFundation.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "NSString+zFundation.h"

@implementation NSString (zFundation)
- (CGSize)sizeWithFont:(UIFont *)font limitedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize retSize = CGSizeZero;
    NSDictionary *attr = @{NSFontAttributeName:(nil==font)?[UIFont systemFontOfSize:14]:font};
    CGRect  rect =[self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attr
                                     context:nil];
    retSize = rect.size;
    return retSize;
}


/**
 *    @brief    校验有效手机号
 *
 *
 *    @return    是否为有效手机号码
 */
- (BOOL)isPhoneNumber

{
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    return [mobileNoTest evaluateWithObject:self];
}

@end
