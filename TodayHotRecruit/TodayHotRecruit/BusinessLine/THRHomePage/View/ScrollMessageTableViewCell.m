//
//  ScrollMessageTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "ScrollMessageTableViewCell.h"
#import "SDCycleScrollView.h"
#import "MessageCollectionViewCell.h"

@interface ScrollMessageTableViewCell()<SDCycleScrollViewDelegate>
// 自定义轮播
@property (nonatomic, strong) SDCycleScrollView *messageScroll;
@end

@implementation ScrollMessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.messageScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, PXGet375Width(10), kScreenWidth, PXGet375Width(50)) delegate:self placeholderImage:nil];
        self.messageScroll.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.messageScroll.imageURLStringsGroup = @[@"1",@"2",@"3"];
        self.messageScroll.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.messageScroll];
        self.contentView.backgroundColor = RGBACOLOR(226, 226, 226, 1);
    }
    return self;
}

-(Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return [MessageCollectionViewCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    MessageCollectionViewCell *myCell = (MessageCollectionViewCell *)cell;
    myCell.titleContentLabel.text = [NSString stringWithFormat:@"%ld",(long)index];
    
}

+(CGFloat)selfHeight{
    return PXGet375Width(70);
}
@end
