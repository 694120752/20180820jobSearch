//
//  IconTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "IconTableViewCell.h"

@implementation IconTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //四个icon
        [self setUpIcon];
        self.contentView.backgroundColor = RANDOMCOLOR;
    }
    return self;
}

-(void)setUpIcon{
    
    UIView* iconContent = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.1, 0, kScreenWidth* 0.8, Get375Width(165 / 2))];
    iconContent.backgroundColor = RANDOMCOLOR;
    
    NSArray* iconArray = @[@"今日热招",@"线下门店",@"专属顾问",@"转盘抽奖"];
    NSArray* iconImage = @[@"icon_1",@"icon_2",@"icon_3",@"icon_4"];
    
    CGFloat buttonWidth = (kScreenWidth * 0.8)/4;
    CGFloat buttonHeight = Get375Width(165 / 2);
    
    for (NSUInteger i = 0; i< iconArray.count; i++) {
        IconButton* button = [IconButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:iconArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:iconImage[i]] forState:UIControlStateNormal];
        [iconContent addSubview:button];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight);
        button.tag = viewTag + i;
        [button addTarget:self action:@selector(selectIcon:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.contentView addSubview:iconContent];
    
}

- (void)selectIcon:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIconWithIndex:)]) {
        [self.delegate selectIconWithIndex:button.tag - viewTag];
    }
}

+(CGFloat)selfHeight{
    return PXGet375Width(165);
}

@end

@implementation IconButton
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    IconButton* button = [super buttonWithType:buttonType];
    button.titleLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    button.titleLabel.textColor = RGBACOLOR(189, 189, 189, 1);
    return button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width, self.height * 0.7);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.frame = CGRectMake(0, self.height * 0.7, self.width, self.height * 0.3);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
