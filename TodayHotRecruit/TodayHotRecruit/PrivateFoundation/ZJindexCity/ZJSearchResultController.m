//
//  ZJSearchResultController.m
//  ZJIndexContacts
//
//  Created by ZeroJ on 16/10/11.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJSearchResultController.h"
#import "ZJCity.h"

#import "BaseTableView.h"
@interface ZJSearchResultController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) BaseTableView *tableView;
@property (copy, nonatomic) ZJCitySearchCellClickHandler searchCityCellClickHandler;

@end

@implementation ZJSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout
    .topSpaceToView(self.navBarItemView, 0)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .bottomEqualToView(self.view);
}

- (void)setupCityCellClickHandler:(ZJCitySearchCellClickHandler)searchCityCellClickHandler {
    _searchCityCellClickHandler = [searchCityCellClickHandler copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellId = @"kCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    cell.textLabel.text = _data[indexPath.row].name;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZJCity *city = _data[indexPath.row];
    if (_searchCityCellClickHandler) {
        _searchCityCellClickHandler(city.name);
    }
}

- (void)setData:(NSArray<ZJCity *> *)data {
    _data = data;
    [self.tableView reloadData];
}

- (BaseTableView *)tableView {
    if (!_tableView) {
        BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor whiteColor];
        // 行高度
        tableView.rowHeight = 44.f;
        _tableView = tableView;
    }
    return _tableView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

@end
