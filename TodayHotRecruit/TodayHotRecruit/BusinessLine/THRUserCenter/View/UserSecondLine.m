//
//  UserSecondLine.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserSecondLine.h"

@implementation UserSecondLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _scoreTitle.font = font(PXGet375Width(30));
    _score.font = font(PXGet375Width(30));
    
    _fd.font = font(PXGet375Width(30));
    _fdTitle.font = font(PXGet375Width(30));
    
    _contitle.font = font(PXGet375Width(30));
}

@end
