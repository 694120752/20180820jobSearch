//
//  JobTimeLineTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobTimeLineTableViewCell.h"
@interface JobTimeLineTableViewCell()
// 上面的一根线
@property (weak, nonatomic) IBOutlet UIView *lineView;

/** 入职补助 内容*/
@property (nonatomic, strong) NSString *contentStr;

/** 增加补助说明*/
@property (nonatomic, strong) UIView *supplyView;

@property (weak, nonatomic) IBOutlet UIView *timeView;
@end

@implementation JobTimeLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.supplyView = [UIView new];
    [self.contentView addSubview:self.supplyView];
    
    NSArray *dayArray = @[@"第1天",@"第7天",@"第15天",@"第30天"];
    // lineView上加四个点
    for (NSUInteger i = 0; i < 4; i++) {
        UIView * round = [[UIView alloc]initWithFrame:CGRectMake(self.lineView.width / 4  * i, -4.5, 10, 10)];
        round.layer.cornerRadius = 5;
        round.backgroundColor = RGBACOLOR(239, 239, 239, 1);
        [self.lineView addSubview:round];
        
        UILabel *dayLabel = [UILabel new];
        dayLabel.text = dayArray[i];
        dayLabel.font = font(Get375Width(12));
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [self.lineView addSubview:dayLabel];
        dayLabel.sd_layout
        .centerXEqualToView(round)
        .bottomSpaceToView(self.timeView, 10)
        .widthIs(Get375Width(50))
        .heightIs(20);
    }
  
}

+ (CGFloat)cellHeightWithContent:(NSString *)content{
    
    // 每个 /n 是30
    if (IsStrEmpty(content)) {
        content = @"";
    }
    NSArray *comapre = [content componentsSeparatedByString:@"\n"];
    return 10 + 20 + 16 + 100 + comapre.count * 30  + 20;
}

// 更新内容
- (void)updateWithArray:(NSArray *)sub andContent:(NSString *)content{
    
    [self.supplyView z_removeAllSubviews];
    NSMutableArray *strArray = [[content componentsSeparatedByString:@"\n"] mutableCopy];
    self.supplyView.frame = CGRectMake(0, 10 + 20 + 16 + 100 + 10, kScreenWidth, strArray.count * 30);
    for (NSUInteger i = 0; i < strArray.count ; i++) {
        NSString * str = [NSString stringWithFormat:@"* %@",strArray[i]];
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 1)];
        UILabel * strLable = [UILabel new];
        strLable.textColor = RGBACOLOR(182, 182, 182, 1);
        strLable.attributedText = attstr;
        strLable.frame = CGRectMake(Get375Width(40), i*30, kScreenWidth - Get375Width(40) *  2, 30);
        [self.supplyView addSubview:strLable];
    }
    
    for (UIView *subButton in self.lineView.subviews) {
        if ([subButton isKindOfClass:[UIButton class]]) {
            [subButton removeFromSuperview];
        }
    }
    
    // 配置 timeLine 在上面加气泡
    for (NSDictionary * dic in sub) {
        NSNumber *days  = EncodeNumberFromDic(dic, @"days");
        NSString *money = EncodeStringFromDic(dic, @"amount");
        if (!IsStrEmpty(money)) {
            UIButton *priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [priceButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
            [priceButton setTitle:[money stringByAppendingString:@"元"] forState:UIControlStateNormal];
            priceButton.userInteractionEnabled = NO;
            [self.lineView addSubview:priceButton];
            priceButton.titleLabel.font = font(Get375Width(10));
            
#warning TODO:应该是 /30 现在数据跨度太小
            priceButton.sd_layout
            .bottomSpaceToView(self.lineView, 10)
            .widthIs(PXGet375Width(105))
            .heightIs(PXGet375Width(60))
            .centerXIs(self.timeView.width * ( [days floatValue]/ 10));
            
            priceButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, Get375Width(5), 0);
            
        }
    }
    
    
}
@end
