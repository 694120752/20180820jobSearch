//
//  THRMessageViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRMessageViewController.h"
#import "THRRequestManager.h"
#import "BaseTableView.h"
#import "NSString+zFundation.h"
#import <MJRefresh.h>
#import "BaseToast.h"


@implementation MessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.messageTitle = [UILabel new];
        self.messageTitle.numberOfLines = 0;
        self.messageTitle.textColor = [UIColor darkTextColor];
        self.messageTitle.font = font(PXGet375Width(25));
        self.messageContent = [UILabel new];
        self.messageContent.numberOfLines = 0;
        self.messageContent.textColor = [UIColor lightGrayColor];
        self.messageContent.font = font(PXGet375Width(23));
        [self.contentView addSubview:self.messageContent];
        [self.contentView addSubview:self.messageTitle];
      
    }
    return self;
}

- (void)setMessageDic:(NSDictionary *)messageDic{
    
    _messageDic = messageDic;
    NSString *titleStr          = EncodeStringFromDic(messageDic, @"title");
    NSString *contentStr        = EncodeStringFromDic(messageDic, @"content");
    
    CGSize titleSize            = [titleStr sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - Get375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize contentSize          = [contentStr sizeWithFont:font(PXGet375Width(23)) limitedSize:CGSizeMake(kScreenWidth - Get375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.messageTitle.text      = titleStr;
    self.messageContent.text    = contentStr;
    
    self.messageTitle.sd_layout
    .heightIs(Get375Width(10) + titleSize.height + Get375Width(5))
    .topSpaceToView(self.contentView, Get375Width(10))
    .rightSpaceToView(self.contentView, Get375Width(20))
    .leftSpaceToView(self.contentView, Get375Width(20));
    
    self.messageContent.sd_layout
    .heightIs(Get375Width(5) + contentSize.height)
    .topSpaceToView(self.messageTitle, 0)
    .rightSpaceToView(self.contentView, Get375Width(20))
    .leftSpaceToView(self.contentView, Get375Width(20));
}

+ (CGFloat)cellHeightWithMessageDic:(NSDictionary *)dic{
    
    NSString *titleStr          = EncodeStringFromDic(dic, @"title");
    NSString *contentStr        = EncodeStringFromDic(dic, @"content");
    
    CGSize titleSize            = [titleStr sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - Get375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize contentSize          = [contentStr sizeWithFont:font(PXGet375Width(23)) limitedSize:CGSizeMake(kScreenWidth - Get375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return Get375Width(10) + Get375Width(10) + titleSize.height + Get375Width(5)*2 + contentSize.height + Get375Width(10);
}
@end

@interface THRMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
/** messageList*/
@property(nonatomic,strong)BaseTableView* messageTableView;
/** dataSource*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation THRMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self.view addSubview:self.messageTableView];
    self.messageTableView.sd_layout
    .topSpaceToView(self.navBarItemView, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0);
}

- (void)setUpNavi{
    self.navBar.titleLabel.text = @"消息";
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backButton.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    cell.messageDic = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MessageCell cellHeightWithMessageDic:self.dataArray[indexPath.row]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 删除动作
    __weak typeof(self)weakSelf = self;
    NSDictionary *messgaeDic = self.dataArray[indexPath.row];
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/message/update"] parameters:@{@"delIds":EncodeStringFromDic(messgaeDic, @"id")} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.messageTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"删除失败"];
    }];
//
}

#pragma mark ----------- lazy

-(BaseTableView *)messageTableView{
    if (!_messageTableView) {
        _messageTableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
        
        __weak typeof(self)weakSelf = self;
        _messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/message/list"] parameters:@{@"pageNo":@"1",@"pageSize":@"10"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 重新赋值数据
                NSDictionary *dataDic = responseObject;
                weakSelf.dataArray = [EncodeArrayFromDic(dataDic, @"dataList") mutableCopy];
                
                [weakSelf.messageTableView.mj_header endRefreshing];
                [weakSelf.messageTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf.messageTableView.mj_header endRefreshing];
            }];
        }];
        
        [_messageTableView.mj_header beginRefreshing];
        [_messageTableView registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
    }
    return _messageTableView;
}

@end
