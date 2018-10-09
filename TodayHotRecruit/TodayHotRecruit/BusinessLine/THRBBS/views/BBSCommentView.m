//
//  BBSCommentView.m
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BBSCommentView.h"
#import "UIImageView+WebCache.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "THRRequestManager.h"

@interface BBSCommentView ()
@property (nonatomic, strong) NSMutableArray *commentViewArray;
/** 评论输入框*/
@property (nonatomic, strong) UITextField *commentField;
@end
@implementation BBSCommentView
-(NSMutableArray *)commentViewArray {
    if (!_commentViewArray) {
        _commentViewArray = [NSMutableArray array];
    }
    return _commentViewArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    [self setBackgroundColor:RGBACOLOR(246, 246, 246, 1)];
}

-(void)setCommentArray:(NSArray *)commentArray isShow:(BOOL)isShow{
    _commentArray = commentArray;
    
    NSInteger orginalLineCount = self.commentViewArray.count;
    NSInteger needsToAddCount = self.commentArray.count > orginalLineCount ? (self.commentArray.count - orginalLineCount) : 0;
    
   
    for (int i = 0; i < needsToAddCount; i++) {
        if (!isShow) {
            break;
        }
      // 添加控件
        UIView* bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        
        UIImageView* avatarImageView = [[UIImageView alloc] init];
        [bgView addSubview:avatarImageView];
        avatarImageView.layer.cornerRadius = 20;
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.tag = 100;
        
        
        UILabel* contentLB = [[UILabel alloc] init];
        [bgView addSubview:contentLB];
        contentLB.tag = 101;
        
        
        [self.commentViewArray addObject:bgView];
        

    }
    
    for (NSInteger i = 0; i < commentArray.count; i++) {
        if (!isShow) {
            break;
        }
        CommentModel* comment = commentArray[i];
        UIView* bgView = self.commentViewArray[i];
        UIImageView* avatarImageView = [bgView viewWithTag:100];
        
        if (comment.avatar) {
            [avatarImageView sd_setImageWithURL:[NSURL URLWithString:comment.avatar]];
        }
        
        UILabel* contentLB = [bgView viewWithTag:101];
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 6;
        NSMutableAttributedString* content = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@",comment.nickName,comment.content] attributes:@{NSForegroundColorAttributeName: RGBACOLOR(120, 120, 120, 1),NSFontAttributeName: [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName: paragraphStyle}];
        contentLB.numberOfLines = 0;
        contentLB.isAttributedContent = YES;
        if (comment.nickName) {
            NSRange range = [content.string rangeOfString:comment.nickName];
            [content addAttributes:@{NSForegroundColorAttributeName: RGBACOLOR(102, 146, 193, 1)} range:range];
        }
       
        contentLB.attributedText = content;
        
        
        if (comment.nickName) {
            [contentLB yb_addAttributeTapActionWithStrings:@[comment.nickName] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
                NSLog(@"点击了用户名: %@", comment.nickName);
            }];
        }
        
    }
    
    if (self.commentViewArray.count) {
        [self.commentViewArray enumerateObjectsUsingBlock:^(UIView *bgView, NSUInteger idx, BOOL *stop) {
            [bgView sd_clearAutoLayoutSettings];
            bgView.hidden = YES;
        }];
    }
    
    if (self.commentField) {
        [self.commentField sd_clearAutoLayoutSettings];
        self.commentField.hidden = YES;
    }
    
    if (!isShow) {
        self.fixedWidth = @(0); // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.fixedHeight = @(0); // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        return;
    } else {
        self.fixedHeight = nil; // 取消固定宽度约束
        self.fixedWidth = nil; // 取消固定高度约束
    }
    
    UIView* tempTopView = nil;

    for (int i = 0; i < self.commentArray.count; i++) {
      
        UIView *bgView = [self.commentViewArray safeObjectAtIndex:i];
        
        if (![bgView isKindOfClass:[UIView class]]) {
            break;
        }
        
        bgView.hidden = NO;
        bgView.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(tempTopView ? tempTopView : self, 0)
        .rightSpaceToView(self, 0);
        
        UIImageView* avatarImageView = [bgView viewWithTag:100];
        avatarImageView.sd_layout
        .leftSpaceToView(bgView, 10)
        .topSpaceToView( bgView, 10)
        .widthIs(40)
        .heightIs(40);
        
        
        UILabel* contentLB = [bgView viewWithTag:101];
        contentLB.sd_layout
        .leftSpaceToView(avatarImageView, 10)
        .topEqualToView(avatarImageView)
        .rightSpaceToView(bgView, 10)
        .autoHeightRatio(0);
        contentLB.isAttributedContent = YES;
        
        [bgView setupAutoHeightWithBottomViewsArray:@[avatarImageView,contentLB] bottomMargin:10];
        
        tempTopView = bgView;
        
    }
    
    UITextField* addCommentField = [UITextField new];
    self.commentField = addCommentField;
    self.commentField.hidden = NO;
    addCommentField.borderStyle = UITextBorderStyleRoundedRect;
    addCommentField.placeholder = @"请输入评论";
    
    UIView *lastTopView = addCommentField;
    [self addSubview:addCommentField];
    addCommentField.sd_layout
    .topSpaceToView(tempTopView, 10)
    .heightIs(30)
    .rightSpaceToView(self, 10)
    .leftSpaceToView(self, 10);
    
    UIButton* subMit = [UIButton buttonWithType:UIButtonTypeCustom];
    subMit.frame = CGRectMake(0, 0, 50, 30);
    
    addCommentField.rightView = subMit;
    addCommentField.rightViewMode = UITextFieldViewModeAlways;
    [subMit setTitle:@"提交" forState:UIControlStateNormal];
    [subMit setTitleColor:RGBACOLOR(142, 142, 142, 1) forState:UIControlStateNormal];
    [subMit addTarget:self action:@selector(commitComent) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];

}

- (void)commitComent{
    
    if (IsStrEmpty(self.commentField.text)) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(subMitCommentWithContent:)]) {
        [self.delegate subMitCommentWithContent:self.commentField.text];
    }
}
@end
