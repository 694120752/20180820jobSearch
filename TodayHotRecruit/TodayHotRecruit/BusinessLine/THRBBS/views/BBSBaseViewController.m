//
//  BBSBaseViewController.m
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BBSBaseViewController.h"
#import "BBSModel.h"
#import "BBSTableViewCell.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
@interface BBSBaseViewController () <UITableViewDataSource, UITableViewDelegate, BBSTableViewCellDelegate>
@property (nonatomic,strong)UITableView* tableView;
@end

@implementation BBSBaseViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

-(void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];

}


-(void)reloadData {
    self.tableDataSource = [self.dataSource datasourceForBBSBaseViewController:self];
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBSTableViewCell* cell = [BBSTableViewCell cellWithTableView:tableView];
    BBSModel* model = self.tableDataSource[indexPath.section];
    cell.bbsModel = model;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBSModel* model = self.tableDataSource[indexPath.section];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"bbsModel" cellClass:[BBSTableViewCell class] contentViewWidth:kScreenWidth] ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark BBSTableViewCellDelegate
-(void)BBSTableViewCell:(BBSTableViewCell *)cell didClickFollowForBBSModel:(BBSModel *)bbsModel {
    
    // 去关注这个人
    
    
    
    NSString *urlStr = [HTTP stringByAppendingString:@"/concernRecord/cancel"];
    NSDictionary *parameters = @{
                                 @"id":bbsModel.userID
                                 };
    if (bbsModel.isFollowed) {
        urlStr = [HTTP stringByAppendingString:@"/concernRecord/add"];
        parameters = @{
                       @"concernUserID":bbsModel.bbsID
                       };
    }
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        bbsModel.isFollowed = !bbsModel.isFollowed;
        [BaseToast toast:@"操作成功"];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"操作失败"];
    }];
    
    
    
}

// 点赞
- (void)BBSTableViewCell:(BBSTableViewCell *)cell didClickLikeForBBSModel:(BBSModel *)bbsModel{
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/forum/like"] parameters:@{@"forumID":bbsModel.bbsID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        bbsModel.likeCount ++;
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


-(void)BBSTableViewCell:(BBSTableViewCell *)cell didClickCommentForBBSModel:(BBSModel *)bbsModel {
    __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            bbsModel.isShowComment = !bbsModel.isShowComment;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationNone];
        });
}

@end
