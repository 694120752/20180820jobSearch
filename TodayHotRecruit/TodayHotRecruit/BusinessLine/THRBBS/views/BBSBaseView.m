//
//  BBSBaseView.m
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BBSBaseView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@interface BBSBaseView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)NSArray* tableDataSource;
@end
@implementation BBSBaseView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}


-(void)setupViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
    self.tableView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedSectionHeaderHeight = 0.01f;
}
-(void)reloadData {
   self.tableDataSource = [self.dataSource dataSourceArrayForRefreshingDataBBSBaseViewDataSource:self];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSString* str = self.tableDataSource[indexPath.row];
    cell.textLabel.text = str;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
@end
