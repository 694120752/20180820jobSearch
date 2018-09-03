//
//  NSString+zFundation.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (zFundation)
- (CGSize)sizeWithFont:(UIFont *)font limitedSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
