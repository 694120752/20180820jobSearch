//
//  RegistViewController.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD.h>

typedef enum : NSUInteger {
    RegistVc,
    FindPassVc,
} THRRegVCType;

@interface RegistViewController : BaseViewController
@property (nonatomic, assign) THRRegVCType vcType;
@end
