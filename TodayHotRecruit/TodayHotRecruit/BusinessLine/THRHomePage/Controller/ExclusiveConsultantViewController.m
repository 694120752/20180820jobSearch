//
//  ExclusiveConsultantViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "ExclusiveConsultantViewController.h"
#import "FSPageContentView.h"
#import "ConsultantSubDataViewController.h"
#import "ConsultantSubActivityViewController.h"

@interface EcContentButtont :UIButton
@end
@interface EcTitleButton :UIButton
// lineView
@property (nonatomic, strong) UIView *lineView;
@end

@implementation EcContentButtont
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    EcContentButtont* button = [super buttonWithType:buttonType];
    [button setTitleColor:RGBACOLOR(59, 59, 59, 1) forState:UIControlStateNormal];
    button.titleLabel.font = font(PXGet375Width(30));
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, PXGet375Width(30));
    return button;
}
@end
@implementation EcTitleButton
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    EcTitleButton* title = [super buttonWithType:buttonType];
    title.titleLabel.font = font(PXGet375Width(28));
    //下面的一根线
    UIView* lineView = [UIView new];
    lineView.backgroundColor = RGBACOLOR(88, 150, 255, 1);
    lineView.layer.shadowColor = RGBACOLOR(88, 150, 255, 1).CGColor;//阴影颜色
    lineView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    lineView.layer.shadowOpacity = 1;//不透明度
    lineView.layer.shadowRadius = 5.0;//半径
    
    title.lineView = lineView;
    [title addSubview:lineView];
    
    CGSize titleSize = [@"要四个字" sizeWithAttributes:@{NSFontAttributeName:font(PXGet375Width(28))}];
    
    title.titleLabel.sd_layout
    .widthIs(titleSize.width)
    .heightIs(titleSize.height)
    .centerXEqualToView(title)
    .topSpaceToView(title, PXGet375Width(25));
    
    lineView.sd_layout
    .widthRatioToView(title.titleLabel, 1)
    .topSpaceToView(title.titleLabel, PXGet375Width(20))
    .heightIs(PXGet375Width(5))
    .centerXEqualToView(title.titleLabel);

    
    [title setTitleColor:RGBACOLOR(146, 146, 146, 1) forState:UIControlStateNormal];
    [title setTitleColor:RGBACOLOR(88, 150, 255, 1) forState:UIControlStateSelected];

    return title;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _lineView.hidden = !selected;
}
@end

@interface ExclusiveConsultantViewController ()<FSPageContentViewDelegate>

// 头像
@property (nonatomic, strong) UIImageView *headerImage;

// 姓名
@property (nonatomic, strong) UILabel *nameLable;

// 手机号
@property (nonatomic, strong) UILabel *phoneNumberLabel;

// buttonView
@property (nonatomic, strong) UIView *buttonView;

// buttonView 上面的按钮
@property (nonatomic, strong) NSArray<EcTitleButton*> *buttonArrays;

// 下方的内容
@property (nonatomic, strong) FSPageContentView *contentView;
@end

@implementation ExclusiveConsultantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpNavi];
    
    [self setUpConsultantCard];
    
    //下面的两个详情
    [self setUpDetail];
    
    //最下面为你服务多少天
    [self setUpServiceDate];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"专属顾问";
    self.navBar.bottomLine.hidden = YES;
}

- (void)setUpConsultantCard{
    // 一个大的背景View 250 + 150
    UIView* bigBGView = [UIView new];
    [self.view addSubview:bigBGView];
    
    bigBGView.sd_layout
    .topSpaceToView(self.navBar, 0)
    .heightIs(PXGet375Width(250) + PXGet375Width(150))
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
    
    // 蓝色的
    UIView* blueView = [UIView new];
    blueView.backgroundColor = CommonBlue;
    [bigBGView addSubview:blueView];
    
    // 灰色的
    UIView* grayView = [UIView new];
    grayView.backgroundColor = RGBACOLOR(239, 239, 239, 1);
    [bigBGView addSubview:grayView];
    
    blueView.sd_layout.topSpaceToView(bigBGView, 0).heightIs(PXGet375Width(250))
    .leftSpaceToView(bigBGView, 0)
    .rightSpaceToView(bigBGView, 0);
    
    grayView.sd_layout.topSpaceToView(blueView, 0)
    .heightIs(PXGet375Width(150))
    .rightSpaceToView(bigBGView, 0)
    .leftSpaceToView(bigBGView, 0);
    
    UIView* card = [UIView new];
    card.backgroundColor = [UIColor whiteColor];
    card.layer.cornerRadius = PXGet375Width(10);
    [bigBGView addSubview:card];
    card.sd_layout
    .topSpaceToView(bigBGView, 0)
    .heightIs(PXGet375Width(380))
    .widthIs(PXGet375Width(660))
    .centerXEqualToView(bigBGView);
    
    UIImageView* headerImage = [UIImageView new];
    self.headerImage = headerImage;
    headerImage.backgroundColor = RANDOMCOLOR;
    [card addSubview:headerImage];
    headerImage.sd_layout
    .topSpaceToView(card, PXGet375Width(15))
    .centerXEqualToView(card)
    .widthIs(PXGet375Width(140))
    .heightIs(PXGet375Width(140));
    [card setNeedsLayout];
    [card layoutIfNeeded];
    [self.view addShadowToView:headerImage withOpacity:0.5 shadowRadius:5 cornerRadius:PXGet375Width(140) / 2 color:[UIColor grayColor] shadowOffset:CGSizeZero];
    
    // 姓名
    UILabel* nameLabel = [UILabel new];
    nameLabel.font = font(PXGet375Width(35));
    nameLabel.textColor = RGBACOLOR(87, 87, 87, 1);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLable = nameLabel;
    [card addSubview:nameLabel];
    nameLabel.sd_layout
    .topSpaceToView(headerImage, PXGet375Width(15))
    .heightIs(PXGet375Width(30))
    .rightSpaceToView(card, 0)
    .leftSpaceToView(card, 0);
    
    nameLabel.text = @"王晓丽";
    
    // 手机号
    UILabel* phone = [UILabel new];
    self.phoneNumberLabel =phone;
    phone.textAlignment = NSTextAlignmentCenter;
    [card addSubview:phone];
    phone.font = font(PXGet375Width(23));
    phone.textColor = RGBACOLOR(157, 157, 157, 1);
    phone.sd_layout
    .topSpaceToView(nameLabel, 0)
    .heightIs(PXGet375Width(40))
    .rightSpaceToView(card, 0)
    .leftSpaceToView(card, 0);
    
    phone.text = @"手机号码：18066666666";
    
    // lineView
    UIView* lineView = [UIView new];
    [card addSubview:lineView];
    lineView.backgroundColor = RGBACOLOR(243, 242, 243, 1);
    lineView.sd_layout
    .topSpaceToView(phone, PXGet375Width(30))
    .heightIs(PXGet375Width(2))
    .widthRatioToView(card, 0.8)
    .centerXEqualToView(card);
    
    // vLine
    UIView*vLine = [UIView new];
    vLine.backgroundColor = RGBACOLOR(243, 242, 243, 1);
    [card addSubview:vLine];
    vLine.sd_layout
    .centerXEqualToView(card)
    .topSpaceToView(lineView, PXGet375Width(22))
    .bottomSpaceToView(card, PXGet375Width(22))
    .widthIs(PXGet375Width(2));
    
    // 发送微信
    EcContentButtont* weChatButton = [EcContentButtont buttonWithType:UIButtonTypeCustom];
    [weChatButton setTitle:@"发送微信" forState:UIControlStateNormal];
    [weChatButton setImage:[UIImage imageNamed:@"weChat_b"] forState:UIControlStateNormal];
    [card addSubview:weChatButton];
    weChatButton.sd_layout
    .topSpaceToView(lineView, 0)
    .bottomSpaceToView(card, 0)
    .rightSpaceToView(vLine, 0)
    .leftSpaceToView(card, 0);
    
    // 立即联系
    EcContentButtont* phoneButton = [EcContentButtont buttonWithType:UIButtonTypeCustom];
    [phoneButton setImage:[UIImage imageNamed:@"phone_b"] forState:UIControlStateNormal];
    [phoneButton setTitle:@"立即联系" forState:UIControlStateNormal];
    [card addSubview:phoneButton];
    phoneButton.sd_layout
    .topSpaceToView(lineView, 0)
    .bottomSpaceToView(card, 0)
    .rightSpaceToView(card, 0)
    .leftSpaceToView(vLine, 0);
    
}

- (void)setUpDetail{
    
    //上面的一行按钮 100
    UIView* buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y + PXGet375Width(250) + PXGet375Width(150), kScreenWidth, PXGet375Width(100))];
    buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView = buttonView;
    EcTitleButton* data = [EcTitleButton buttonWithType:UIButtonTypeCustom];
    data.selected = YES;
    [data addTarget:self action:@selector(titleTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    [data setTitle:@"个人资料" forState:UIControlStateNormal];
    [buttonView addSubview:data];
    EcTitleButton* act = [EcTitleButton buttonWithType:UIButtonTypeCustom];
    [act addTarget:self action:@selector(titleTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    act.selected = NO;
    [act setTitle:@"顾问动态" forState:UIControlStateNormal];
    [buttonView addSubview:act];
    
    self.buttonArrays = @[data,act];
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = RGBACOLOR(243, 242, 243, 1);
    [buttonView addSubview:lineView];
    lineView.sd_layout
    .heightIs(PXGet375Width(2))
    .rightSpaceToView(buttonView, 0)
    .leftSpaceToView(buttonView, 0)
    .bottomSpaceToView(buttonView, 0);
    
    UIView*vLine = [UIView new];
    vLine.backgroundColor = RGBACOLOR(243, 242, 243, 1);
    [buttonView addSubview:vLine];
    vLine.sd_layout
    .centerXEqualToView(buttonView)
    .topSpaceToView(lineView, PXGet375Width(20))
    .bottomSpaceToView(buttonView, PXGet375Width(20))
    .widthIs(PXGet375Width(2));
    
    [self.view addSubview:buttonView];
    
    data.sd_layout
    .topSpaceToView(buttonView, 0)
    .rightSpaceToView(vLine, 0)
    .leftSpaceToView(buttonView, 0)
    .bottomSpaceToView(lineView, 0);
    
    act.sd_layout
    .topSpaceToView(buttonView, 0)
    .rightSpaceToView(buttonView, 0)
    .leftSpaceToView(vLine, 0)
    .bottomSpaceToView(lineView, 0);
    
    
    //下面的具体内容
    FSPageContentView* content = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, PXGet375Width(250) + PXGet375Width(150) + NavigationBar_Bottom_Y + PXGet375Width(100), kScreenWidth, kScreenHeight - PXGet375Width(250) - PXGet375Width(150) - NavigationBar_Bottom_Y - PXGet375Width(100)) childVCs:@[[ConsultantSubDataViewController new],[ConsultantSubActivityViewController new]] parentVC:self delegate:self];
    _contentView = content;
    [self.view addSubview:content];
    
}

- (void)setUpServiceDate{
    // 已为您服务 多少天
}


// 滑动反馈
- (void)setButtonViewSelectIndex:(NSUInteger)index{
    
    //滑动到个人资料了
    if (index == 0) {
        self.buttonArrays[0].selected = YES;
        self.buttonArrays[1].selected = NO;
    }else{
        self.buttonArrays[0].selected = NO;
        self.buttonArrays[1].selected = YES;
    }
    
}

// 按钮点击反馈
- (void)titleTouchAction:(EcTitleButton*)button{
    if ([button.titleLabel.text isEqualToString:@"个人资料"]) {
        _contentView.contentViewCurrentIndex = 0;
        self.buttonArrays[0].selected = YES;
        self.buttonArrays[1].selected = NO;
    }else{
        _contentView.contentViewCurrentIndex = 1;
        self.buttonArrays[0].selected = NO;
        self.buttonArrays[1].selected = YES;
    }
}



#pragma mark ---- FSContenViewDidEndDecelerating
-(void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    //通知buttonView改变状态
    [self setButtonViewSelectIndex:endIndex];
}

@end
