//
//  BannerTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BannerTableViewCell : BaseTableViewCell

-(void)updateWithURL:(NSArray*)urlArray;

+(CGFloat)cellHeight;
@end
