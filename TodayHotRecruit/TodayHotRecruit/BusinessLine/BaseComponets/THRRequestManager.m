//
//  THRRequestManager.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRRequestManager.h"


@implementation THRRequestManager
+ (THRRequestManager* )manager{
    
    THRRequestManager *manager = [super manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return manager;
}
@end
