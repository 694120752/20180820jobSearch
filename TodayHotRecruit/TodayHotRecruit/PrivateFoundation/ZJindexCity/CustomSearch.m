//
//  customSearch.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/31.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "CustomSearch.h"

@implementation CustomSearch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView* subView in self.subviews) {
        for (UIView* ssubView in subView.subviews) {
            if ([ssubView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                ssubView.layer.cornerRadius = PXGet375Width(35);
                ssubView.clipsToBounds  = YES;
            }
        }
    }
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
