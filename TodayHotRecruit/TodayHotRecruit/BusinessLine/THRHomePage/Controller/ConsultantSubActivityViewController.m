//
//  ConsultantSubActivityViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "ConsultantSubActivityViewController.h"
#import "BaseTableView.h"
#import "THRRequestManager.h"
@interface ConsultantSubActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
/** baseTableView*/
@property(nonatomic,strong)BaseTableView* tableView;
/** data*/
@property(nonatomic,strong)NSArray* dataArray;
@end

@implementation ConsultantSubActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    //主体tableView
    BaseTableView* base = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = base;
    base.dataSource = self;
    base.delegate = self;
    [self.view addSubview:base];
    
    base.sd_layout
    .topSpaceToView(self.view, PXGet375Width(0))
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    
    NSString *type = EncodeStringFromDic(dataDic, @"eventType");
    NSString *userNick = EncodeStringFromDic(dataDic, @"userNickName");
    
    
    if ([type isEqualToString:@"4"]) {
        // 打电话
        cell.textLabel.text =[userNick stringByAppendingString:@"拨打了顾问电话"];
    }else if([ type isEqualToString:@"3"]){
        
        cell.textLabel.text =[userNick stringByAppendingString:@"发送了微信"];
    }else if([type isEqualToString:@"2"]){
        // 分享
        cell.textLabel.text =[userNick stringByAppendingString:@"推荐了该顾问"];
    }else{
        // 复制了微信
       cell.textLabel.text =[userNick stringByAppendingString:@"获取了微信"];
    }
    
    cell.textLabel.font = font(18);
    
    
    
    cell.detailTextLabel.text = EncodeStringFromDic(dataDic, @"createTime");
    cell.detailTextLabel.font = font(16);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/eventRecord/list"] parameters:@{@"type":@(3)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* resDic = responseObject;
        weakSelf.dataArray = EncodeArrayFromDic(resDic, @"dataList");
        [weakSelf.tableView reloadData];
    } failure:nil];
    
}

@end
