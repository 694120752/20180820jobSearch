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
#import "THRRequestManager.h"

@interface ScrollMessageTableViewCell()<SDCycleScrollViewDelegate>
// 自定义轮播
@property (nonatomic, strong) SDCycleScrollView *messageScroll;

/** */
@property(nonatomic,strong)NSArray* dicArray;
@end

@implementation ScrollMessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.messageScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, PXGet375Width(10), kScreenWidth, PXGet375Width(50)) delegate:self placeholderImage:nil];
        self.messageScroll.scrollDirection = UICollectionViewScrollDirectionVertical;
        //self.messageScroll.imageURLStringsGroup = @[@"1",@"2",@"3"];
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
    NSDictionary* data = self.dicArray[index];
    myCell.titleContentLabel.text = [[EncodeStringFromDic(data, @"userNickName") stringByAppendingString:@"领取了"] stringByAppendingString:EncodeStringFromDic(data, @"amount")];
    myCell.timeLabel.text = EncodeStringFromDic(data, @"createTime");
}

- (void)upDateData{
    
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userAmountRecord/list"] parameters:@{@"pageNo":@"1",@"pageSize":@"10"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if ([desc isEqualToString:@"success"]) {
            weakSelf.dicArray = EncodeArrayFromDic(resultDic, @"dataList");
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary* dic in weakSelf.dicArray) {
                [temp addObject:EncodeStringFromDic(dic, @"id")];
            }
            weakSelf.messageScroll.imageURLStringsGroup = [temp copy];
        }
    } failure:nil];
}

+(CGFloat)selfHeight{
    return PXGet375Width(70);
}

-(NSArray *)dicArray{
    if (!_dicArray) {
        _dicArray = [NSArray array];
    }
    return _dicArray;
}
@end
