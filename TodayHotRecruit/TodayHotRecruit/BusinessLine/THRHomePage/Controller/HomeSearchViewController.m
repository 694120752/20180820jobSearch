//
//  HomeSearchViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()

@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置 navi
    
    [self setUpNavi];
}

-(void)setUpNavi{
    self.navBarItemView.backgroundColor = CommmonBlue;
    self.navBar.backgroundColor = CommmonBlue;

}

@end
