//
//  UserHeaderLineTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserHeaderLineTableViewCell.h"
#import "UserSecondLine.h"
#import "UserDetail.h"
#import "UIImageView+WebCache.h"
#import "ExclusiveConsultantViewController.h"

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

@interface UserHeaderLineTableViewCell()
@property (nonatomic, strong) UserSecondLine *second;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) PhoneButton *phone;
// 认证状态
@property (nonatomic, strong) UILabel *cerLabel;
@property (nonatomic, strong) UIImageView *headerImage;
@end

@implementation UserHeaderLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = CommonBlue;
        //分成两行 第一行为头像 h:180  第二行为展示按钮 h:100
        [self setUpFirstLine];
        [self setUpSecondLine];
        
    }
    return self;
}

- (void)setUpFirstLine{
    // headerImage
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(PXGet375Width(30) + Top_iPhoneX_SPACE, PXGet375Width(40), PXGet375Width(100), PXGet375Width(100))];
    _headerImage = headerImage;
    headerImage.backgroundColor = RANDOMCOLOR;
    headerImage.layer.cornerRadius = PXGet375Width(50);
    headerImage.clipsToBounds = YES;
    headerImage.userInteractionEnabled = YES;
    [self.contentView addSubview:headerImage];
    
    //认证tag
    UILabel* cerLabel = [[UILabel alloc]init];
    _cerLabel = cerLabel;
//    cerLabel.text = @"未认证";
    cerLabel.textColor = [UIColor whiteColor];
    cerLabel.frame = CGRectMake(headerImage.mj_x + PXGet375Width(10) / 2, headerImage.mj_y + headerImage.mj_h - PXGet375Width(30)/2, headerImage.mj_w - PXGet375Width(10), PXGet375Width(30));
    cerLabel.backgroundColor = RGBACOLOR(205, 205, 205, 1);
    cerLabel.layer.cornerRadius = PXGet375Width(15);
    cerLabel.clipsToBounds = YES;
    cerLabel.font = [UIFont systemFontOfSize:PXGet375Width(20)];
    cerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:cerLabel];
  
    //用户名
    UILabel* userName = [[UILabel alloc]initWithFrame:CGRectMake(headerImage.mj_x + headerImage.mj_w + PXGet375Width(30), headerImage.mj_y, iPhoneX?PXGet375Width(350):PXGet375Width(400), PXGet375Width(50))];
    _userName = userName;
    userName.textColor = [UIColor whiteColor];
    userName.font = [UIFont systemFontOfSize:PXGet375Width(35)];
    [self.contentView addSubview:userName];
    
    //用户电话
    PhoneButton *userPhone = [PhoneButton buttonWithType:UIButtonTypeCustom];
    _phone = userPhone;
    [userPhone setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    userPhone.frame = CGRectMake(userName.mj_x, userName.mj_y + userName.height + PXGet375Width(5), PXGet375Width(400), PXGet375Width(50));
    //[userPhone setTitle:@"18066666666" forState:UIControlStateNormal];
    userPhone.userInteractionEnabled = NO;
    
    [self.contentView addSubview:userPhone];
    
    //二维码 + 右箭头
    QRButton* qr = [QRButton buttonWithType:UIButtonTypeCustom];
    qr.mj_origin = CGPointMake(kScreenWidth - (kScreenWidth - userName.mj_x - userName.mj_w), 0);
    // 关闭交互 交由cell处理
    qr.userInteractionEnabled = NO;
    [self.contentView addSubview:qr];
    qr.sd_layout.rightSpaceToView(self.contentView, 5);
    
    
}

- (void)setUpSecondLine{
    
    //三个按钮
    UserSecondLine *second = [[[NSBundle mainBundle] loadNibNamed:@"UserSecondLine" owner:self options:nil] lastObject];
    _second = second;
    second.frame = CGRectMake(0, 0, kScreenWidth, PXGet375Width(80));
    // 无语。。。。
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, PXGet375Width(180), kScreenWidth, PXGet375Width(80))];
    [backView addSubview:second];
    
    [second.conButton addTarget:self action:@selector(checkConsultantInfo) forControlEvents:UIControlEventTouchUpInside];
    [second.myScore addTarget:self action:@selector(myScoreAction) forControlEvents:UIControlEventTouchUpInside];
    [second.myFd addTarget:self action:@selector(myFdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:backView];
    
    // 添加空白事件 点击前两个Label的时候不响应
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [second addGestureRecognizer:tapGesturRecognizer];
    
    
}

- (void)upDateData{
    NSDictionary* ud = [UserDetail getDetail];
    _second.score.text = EncodeStringFromDic(ud, @"points");
    _second.fd.text = EncodeStringFromDic(ud, @"amount");
    _userName.text = EncodeStringFromDic(ud, @"nickName");
    [_phone setTitle:EncodeStringFromDic(ud, @"phone") forState:UIControlStateNormal];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(ud, @"portraitRequestUrl")] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
     NSNumber* mark = EncodeNumberFromDic(ud, @"realFlag");
    if ([mark integerValue] == 0) {
        _cerLabel.text = @"未认证";
        _cerLabel.backgroundColor = RGBACOLOR(205, 205, 205, 1);
    }else if ([mark integerValue] == 1){
        _cerLabel.text = @"已认证";
        _cerLabel.backgroundColor = RGBACOLOR(247, 201, 71, 1);
    }else if ([mark integerValue] == 2){
        _cerLabel.text = @"待审核";
        _cerLabel.backgroundColor = RGBACOLOR(205, 205, 205, 1);
    }
}

+ (CGFloat)selfHeight{
    return PXGet375Width(290);
}

- (void)checkConsultantInfo{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToExclusiveVc)]) {
        [self.delegate jumpToExclusiveVc];
    }
}

- (void)myScoreAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToMyScore)]) {
        [self.delegate jumpToMyScore];
    }
}

- (void)myFdAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToMyfd)]) {
        [self.delegate jumpToMyfd];
    }
}

- (void)tapAction{}
@end

