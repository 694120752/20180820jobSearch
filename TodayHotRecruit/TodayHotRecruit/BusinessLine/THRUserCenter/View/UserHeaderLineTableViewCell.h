//
//  UserHeaderLineTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface QRButton : UIButton
@property (nonatomic, strong) UIImageView *QRImage;
@property (nonatomic, strong) UIImageView *forWardImage;
@end

@interface ScoreButton : UIButton
@property (nonatomic, strong) UILabel *scrollLabel;
@property (nonatomic, strong) UILabel *detaillabel;
+(instancetype)buttonWithType:(UIButtonType)buttonType andIsLast:(BOOL)condition;
@end

@interface PhoneButton : UIButton
@end

@interface UserHeaderLineTableViewCell : BaseTableViewCell
+ (CGFloat)selfHeight;
@end
