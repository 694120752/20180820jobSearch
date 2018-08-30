//
//  UserCenterTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface UserCenterTableViewCell : BaseTableViewCell

@property (nonatomic, assign) NSUInteger titleIndex;

// iCon
@property (nonatomic, strong) UIImageView *iconImage;

// textContent
@property (nonatomic, strong) UILabel *contentLabel;

// rightArrow
@property (nonatomic, strong) UIImageView *rightArr;

// rightlabel
@property (nonatomic, strong) UILabel *rightLabel;

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isNeedEnlarge:(BOOL)isNeed;

+ (CGFloat)selfHeight;
@end
