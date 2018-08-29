//
//  UserHeaderLineTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserHeaderLineTableViewCell.h"
#import "UserSecondLine.h"


@implementation ScoreButton
+(instancetype)buttonWithType:(UIButtonType)buttonType andIsLast:(BOOL)condition{
    ScoreButton *button = [super buttonWithType:UIButtonTypeCustom];
    
    return button;
}
@end

@implementation QRButton
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    QRButton* button = [super buttonWithType:buttonType];
    button.mj_size = CGSizeMake(PXGet375Width(160), PXGet375Width(175));
    button.QRImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QR"]];
    button.forWardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forward"]];
    [button addSubview:button.QRImage];
    [button addSubview:button.forWardImage];
    return button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    /// 70*70
    self.QRImage.frame = CGRectMake(0, (PXGet375Width(175) - PXGet375Width(70))/2, PXGet375Width(70), PXGet375Width(70));
    self.forWardImage.frame = CGRectMake(PXGet375Width(70) + PXGet375Width(40), (PXGet375Width(175) - PXGet375Width(70))/2, PXGet375Width(50), PXGet375Width(70));
    
}
@end

@implementation PhoneButton
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 图片靠左
    self.imageView.frame = CGRectMake(PXGet375Width(2), 0, PXGet375Width(30), PXGet375Width(50) - PXGet375Width(4));
    self.titleLabel.mj_x = PXGet375Width(40);
}
@end

@implementation UserHeaderLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RGBACOLOR(66, 146, 255, 1);
        //分成两行 第一行为头像 h:180  第二行为展示按钮 h:100
        [self setUpFirstLine];
        [self setUpSecondLine];
        
    }
    return self;
}

- (void)setUpFirstLine{
    // headerImage
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(PXGet375Width(30) + Top_iPhoneX_SPACE, PXGet375Width(40), PXGet375Width(100), PXGet375Width(100))];
//    headerImage.image = [UIImage imageNamed:@"placeHolder"];
    headerImage.backgroundColor = RANDOMCOLOR;
    headerImage.layer.cornerRadius = PXGet375Width(50);
    headerImage.clipsToBounds = YES;
    [self.contentView addSubview:headerImage];
    
    //认证tag
    UILabel* cerLabel = [[UILabel alloc]init];
    cerLabel.text = @"未认证";
    cerLabel.textColor = [UIColor whiteColor];
    cerLabel.frame = CGRectMake(headerImage.mj_x + PXGet375Width(10), headerImage.mj_y + headerImage.mj_h - PXGet375Width(30)/2, headerImage.mj_w - 2*PXGet375Width(10), PXGet375Width(30));
    cerLabel.backgroundColor = RGBACOLOR(205, 205, 205, 1);
    cerLabel.layer.cornerRadius = PXGet375Width(15);
    cerLabel.clipsToBounds = YES;
    cerLabel.font = [UIFont systemFontOfSize:PXGet375Width(20)];
    cerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:cerLabel];
  
    //用户名
    UILabel* userName = [[UILabel alloc]initWithFrame:CGRectMake(headerImage.mj_x + headerImage.mj_w + PXGet375Width(30), headerImage.mj_y, PXGet375Width(400), PXGet375Width(50))];
    userName.text = @"用户名";
    userName.textColor = [UIColor whiteColor];
    userName.font = [UIFont systemFontOfSize:PXGet375Width(35)];
    [self.contentView addSubview:userName];
    
    //用户电话
    PhoneButton *userPhone = [PhoneButton buttonWithType:UIButtonTypeCustom];
    [userPhone setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    userPhone.frame = CGRectMake(userName.mj_x, userName.mj_y + userName.height + PXGet375Width(5), PXGet375Width(400), PXGet375Width(50));
    [userPhone setTitle:@"18066666666" forState:UIControlStateNormal];
    userPhone.userInteractionEnabled = NO;
    [self.contentView addSubview:userPhone];
    
    //二维码 + 右箭头
    QRButton* qr = [QRButton buttonWithType:UIButtonTypeCustom];
    qr.mj_origin = CGPointMake(kScreenWidth - (kScreenWidth - userName.mj_x - userName.mj_w), 0);
    [self.contentView addSubview:qr];
}

- (void)setUpSecondLine{
    
    //三个按钮
    UserSecondLine *second = [[[NSBundle mainBundle] loadNibNamed:@"UserSecondLine" owner:self options:nil] lastObject];
    second.frame = CGRectMake(0, 0, kScreenWidth, PXGet375Width(80));
    // 无语。。。。
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, PXGet375Width(180), kScreenWidth, PXGet375Width(80))];
    [backView addSubview:second];
    [self.contentView addSubview:backView];
 
    
}

+ (CGFloat)selfHeight{
    return PXGet375Width(280) + Top_iPhoneX_SPACE;
}
@end
