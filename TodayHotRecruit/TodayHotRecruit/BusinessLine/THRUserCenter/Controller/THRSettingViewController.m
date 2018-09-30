//
//  THRSettingViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/18.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#ifndef CachePath
#define CachePath
#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define LibraryPath NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject
#define TempPath NSTemporaryDirectory()
#endif

#import "THRSettingViewController.h"
#import "LoginViewController.h"
#import "THRRequestManager.h"
// 清除缓存
@interface CacheTool :NSObject
+(CGFloat)cacheSize;
+(void)cleanCaches;
@end
@implementation CacheTool

//计算全部缓存文件大小
+ (CGFloat)cacheSize{
    return [self folderSizeAtPath:DocumentPath] + [self folderSizeAtPath:LibraryPath] + [self folderSizeAtPath:TempPath];
}
//删除全部缓存
+ (void)cleanCaches{
    [self cleanCache:DocumentPath];
    [self cleanCache:LibraryPath];
    [self cleanCache:TempPath];
}

// 计算单个目录缓存文件大小
+ (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
+ (void)cleanCache:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end

@interface THRSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 系统客服电话*/
@property(nonatomic,strong)NSString* customer;
@end

@implementation THRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self setLogOut];
    
    [self setContentTbaleView];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"设置";
}

- (void)setLogOut{
    UIButton* logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutBtn.backgroundColor = CommonBlue;
    logOutBtn.layer.cornerRadius = 8;
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];
    
    logOutBtn.sd_layout
    .topSpaceToView(self.view, PXGet375Width(80 + 400) + NavigationBar_Bottom_Y)
    .centerXEqualToView(self.view)
    .widthIs(PXGet375Width(260))
    .heightIs(PXGet375Width(80));
}

- (void)logOutAction{
    
    UserDefault
    [ud setValue:@"NO" forKey:@"isLogin"];
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"用户反馈";
        cell.detailTextLabel.text = EncodeStringFromDic([UserDetail getDetail], @"nickName");
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"联系我们";
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"清除缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M",[CacheTool cacheSize]];
    }
    
    if (indexPath.row == 3) {
        cell.textLabel.text = @"当前版本 v1.11";
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Get375Width(50);
}

- (void)setContentTbaleView{
    UITableView* settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, Get375Width(50) * 4) style:UITableViewStylePlain];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.bounces = NO;
    [self.view addSubview:settingTableView];
    
    // 获取联系我们的信息
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@""] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:nil];
}

@end
