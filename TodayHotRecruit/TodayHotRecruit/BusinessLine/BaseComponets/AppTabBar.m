//
//  AppTabBar.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "AppTabBar.h"

@implementation AppTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView* view = [super hitTest:point withEvent:event];
    return view;
}



@end
