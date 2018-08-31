//
//  AppTabBarController.m
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/22.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "AppTabBarController.h"

//VC
#import "HomePageNavController.h"
#import "HomePageViewController.h"
#import "THRBBSViewController.h"
#import "THRMessageViewController.h"
#import "THRUserCenterViewController.h"

//Tab
#import "AppTabBar.h"

@interface AppTabBarController ()

@end

@implementation AppTabBarController

-(instancetype)init{
    if (self = [super init]) {
//        self.hidesBottomBarWhenPushed = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGBHex:0x666666], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:SNO2OThemeColor,NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomePageNavController* homeNavi = [[HomePageNavController alloc]initWithRootViewController:[[HomePageViewController alloc]init]];
    homeNavi.tabBarItem.title = @"找工作";
    homeNavi.hidesBottomBarWhenPushed = NO;
    homeNavi.tabBarItem.accessibilityLabel = @"找工作";
    homeNavi.tabBarItem.image = [UIImage imageNamed:@"jobSearch_u"];
    homeNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"jobSearch_s"];
    
    BaseNavigationController* message = [[BaseNavigationController alloc]initWithRootViewController:[[THRMessageViewController alloc]init]];
    message.tabBarItem.title = @"消息";
    message.hidesBottomBarWhenPushed = NO;
    message.tabBarItem.accessibilityLabel = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"message_u"];
    message.tabBarItem.selectedImage = [UIImage imageNamed:@"message_s"];
    
    BaseNavigationController* bbs =  [[BaseNavigationController alloc]initWithRootViewController:[[THRBBSViewController alloc]init]];
    bbs.tabBarItem.title = @"消息天地";
    bbs.hidesBottomBarWhenPushed = NO;
    bbs.tabBarItem.image = [UIImage imageNamed:@"bbs_u"];
    bbs.tabBarItem.selectedImage = [UIImage imageNamed:@"bbs_s"];
    
    BaseNavigationController* userCenter =  [[BaseNavigationController alloc]initWithRootViewController:[[THRUserCenterViewController alloc]init]];
    userCenter.tabBarItem.title = @"我的";
    userCenter.hidesBottomBarWhenPushed = NO;
    userCenter.tabBarItem.image = [UIImage imageNamed:@"mine_u"];
    userCenter.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_s"];
    self.selectedIndex = 1;
    self.viewControllers = @[homeNavi,message,bbs,userCenter];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    AppTabBar *tabbar = [[AppTabBar alloc] init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
//
//    [self performSelectorOnMainThread:@selector(tabBarController:didSelectViewController:) withObject:[self.tabBarController.viewControllers objectAtIndex:0] waitUntilDone:NO];
    
//    self.selectedIndex = 0;
    //[self.tabBarController performSelector:@selector(_tabBarItemClicked:) withObject:0 afterDelay:0];
}
@end
