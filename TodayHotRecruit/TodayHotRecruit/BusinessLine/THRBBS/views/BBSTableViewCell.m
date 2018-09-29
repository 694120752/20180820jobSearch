//
//  BBSTableViewCell.m
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BBSTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "YCPhotoBrowserController.h"
#import "YCPhotoBrowserAnimator.h"
#import "CommentModel.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "BBSCommentView.h"
#define TEXT_COLOR [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1]
@interface BBSTableViewCell () <AnimatorPresentedDelegate>
@property (nonatomic, strong)UIImageView* avatarImageView;
@property (nonatomic, strong)UILabel* nameLB;
@property (nonatomic, strong)UILabel* contentLB;
@property (nonatomic, strong)UIButton* followButton;

@property (nonatomic, strong)NSMutableArray* imageViewArray;
@property (nonatomic, strong)NSMutableArray* bottomButtonArray;

@property (nonatomic, strong)BBSCommentView* commentView;
@end;
@implementation BBSTableViewCell
-(NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

-(NSMutableArray *)bottomButtonArray {
    if (!_bottomButtonArray) {
        _bottomButtonArray = [NSMutableArray array];
    }
    return _bottomButtonArray;
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    NSString* identifier = @"BBS";
    BBSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[BBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews {
    self.avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImageView];
    self.avatarImageView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .heightIs(40)
    .widthIs(40)
    .topSpaceToView(self.contentView, 10);
    self.avatarImageView.layer.cornerRadius = 20;
    self.avatarImageView.layer.masksToBounds = YES;
    
    self.nameLB = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLB];
    self.nameLB.sd_layout
    .centerYEqualToView(self.avatarImageView)
    .leftSpaceToView(self.avatarImageView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(30);
    self.nameLB.font = [UIFont systemFontOfSize:14];
    self.nameLB.textColor = TEXT_COLOR;
    
    self.contentLB = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentLB];
    self.contentLB.sd_layout
    .leftEqualToView(self.avatarImageView)
    .topSpaceToView(self.avatarImageView, 10)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    self.contentLB.numberOfLines = 0;
    self.contentLB.font = [UIFont systemFontOfSize:14];
    self.contentLB.textColor = TEXT_COLOR;
    
    
    UIColor* buttonColor = [UIColor colorWithRed:93/255.0 green:157/255.0 blue:248/255.0 alpha:1];
    self.followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    [self.followButton setTitle:@"已关注" forState:UIControlStateDisabled];
    [self.followButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [self.followButton setTitleColor:TEXT_COLOR forState:UIControlStateDisabled];
    self.followButton.layer.borderColor = buttonColor.CGColor;
    [self.followButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:self.followButton];
    [self.followButton addTarget:self action:@selector(followClickHandle) forControlEvents:UIControlEventTouchUpInside];
    self.followButton.sd_layout
    .centerYEqualToView(self.nameLB)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(60)
    .heightIs(30);
    
    
    CGFloat margin = 15;
    CGFloat buttonWidth = (kScreenWidth - 4 * margin) / 3;
    UIButton* last = nil;
    for (NSInteger i = 0 ; i < 3; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [self.contentView addSubview:button];
        button.sd_layout
        .leftSpaceToView(self.contentView, margin + i * (margin + buttonWidth))
        .topSpaceToView(self.contentLB, 10)
        .widthIs(buttonWidth)
        .heightIs(0);
        [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageViewArray addObject:button];
        [button addTarget:self action:@selector(imageClickHandle:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            last = button;
        }
    }
    

    
    UIButton* shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"102" forState:UIControlStateNormal];
    [self.contentView addSubview:shareButton];
    shareButton.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(last, 10)
    .widthRatioToView(self.contentView, 0.33333)
    .heightIs(40);
    [self.bottomButtonArray addObject:shareButton];
    [shareButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [shareButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
 
    shareButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    shareButton.layer.borderWidth = 0.4;
    
    
    
    UIButton* commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setTitle:@"0" forState:UIControlStateNormal];
    [self.contentView addSubview:commentButton];
    commentButton.sd_layout
    .leftSpaceToView(shareButton, 0)
    .topSpaceToView(last, 10)
    .widthRatioToView(self.contentView, 0.33333)
    .heightIs(40);
    [self.bottomButtonArray addObject:commentButton];
    [commentButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [commentButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [commentButton addTarget:self action:@selector(commentButtonClickHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    commentButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    commentButton.layer.borderWidth = 0.4;
    [commentButton setBackgroundColor:[UIColor whiteColor]];
    
    UIButton* zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanButton setTitle:@"300" forState:UIControlStateNormal];
    [self.contentView addSubview:zanButton];
    zanButton.sd_layout
    .leftSpaceToView(commentButton, 0)
    .topSpaceToView(last, 10)
    .widthRatioToView(self.contentView, 0.33333)
    .heightIs(40);
    [self.bottomButtonArray addObject:zanButton];
    [zanButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [zanButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    zanButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    zanButton.layer.borderWidth = 0.4;
    
    self.commentView = [[BBSCommentView alloc] init];
    [self.contentView addSubview:self.commentView];
    self.commentView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(shareButton, 0);


}



-(void)setBbsModel:(BBSModel *)bbsModel {
    _bbsModel = bbsModel;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:bbsModel.avatar]];
    
    [self.nameLB setText:bbsModel.nickName];
    
    self.contentLB.text = bbsModel.content;
    
    
    [self.followButton setEnabled:!bbsModel.isFollowed];
    self.followButton.layer.borderWidth = bbsModel.isFollowed ?  0 : 1;
    
    CGFloat margin = 15;
    CGFloat buttonWidth = (kScreenWidth - 4 * margin) / 3;
    for (NSInteger i = 0 ; i < 3; i++) {
        UIButton* button = self.imageViewArray[i];
        if (i < bbsModel.pics.count) {
            NSString* pic = bbsModel.pics[i];
            [button sd_setImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            button.sd_layout
            .heightIs(buttonWidth * 0.8);
        } else {
            button.sd_layout
            .heightIs(0);
        }
    }
   
    
    UIButton* commentButton = self.bottomButtonArray[1];
    [commentButton setTitle:[NSString stringWithFormat:@"%zd",self.bbsModel.comments.count] forState:UIControlStateNormal];
    commentButton.selected = bbsModel.isShowComment;
    if (commentButton.selected && self.bbsModel.comments.count > 0) {
        [commentButton setBackgroundColor:RGBACOLOR(219, 229, 241, 1)];
    } else {
        [commentButton setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self.commentView setCommentArray:bbsModel.comments isShow: bbsModel.isShowComment];
    
    UIView *bottomView;
    
    if (!bbsModel.comments.count || !bbsModel.isShowComment) {
        bottomView = commentButton;
    } else {
        bottomView = self.commentView;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];

}


- (UIImageView *)imageViewWithIndexPath:(NSIndexPath *)index{
    UIButton* button = [self.imageViewArray objectAtIndex:index.item];
    UIImageView* imageView = button.imageView;
    return imageView;
}

#pragma mark private methods
-(void)imageClickHandle:(UIButton*)button {
    YCPhotoBrowserAnimator *browserAnimator = [[YCPhotoBrowserAnimator alloc] initWithPresentedDelegate:self];

    YCPhotoBrowserController *vc = [YCPhotoBrowserController instanceWithShowImagesURLs:self.bbsModel.pics urlReplacing:nil];

    vc.placeholder = [UIImage imageNamed:@"timg"];
    vc.indexPath = [NSIndexPath indexPathForItem:button.tag inSection:0];
    vc.browserAnimator = browserAnimator;
    ///长按的回调
    [vc setLongPressBlock:^{
        
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)followClickHandle {
    [self.delegate BBSTableViewCell:self didClickFollowForBBSModel:self.bbsModel];
}

-(void)commentButtonClickHandle:(UIButton*)button {
    if (self.bbsModel.comments.count <= 0) {
        return;
    }
   
    [self.delegate BBSTableViewCell:self didClickCommentForBBSModel:self.bbsModel];

}

@end