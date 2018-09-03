//
//  LoginField.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "LoginField.h"

@interface LoginField ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation LoginField

-(instancetype)init{
    if (self = [super init]) {
//        self.textInputView.backgroundColor = [UIColor redColor];
        UIView *lineView = [[UIView alloc]init];
        _lineView = lineView;
        lineView.backgroundColor = RGBACOLOR(141, 142, 143, 0.4);
        [self.textInputView addSubview:lineView];
        self.textColor = RGBACOLOR(141, 142, 143, 1);
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    _lineView.sd_layout
    .heightIs(1)
    .leftSpaceToView(self.textInputView, 10)
    .rightSpaceToView(self.textInputView, 0)
    .bottomSpaceToView(self.textInputView, 0);
}
@end
