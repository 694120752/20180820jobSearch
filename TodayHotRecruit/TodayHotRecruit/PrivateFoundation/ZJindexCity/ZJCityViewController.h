//
//  ViewController.h
//  ZJIndexContacts
//
//  Created by ZeroJ on 16/10/10.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJCitiesGroup.h"
#import "BaseViewController.h"

@interface ZJCityViewController : BaseViewController
typedef void(^ZJCitySelectedHandler)(NSString *title);
/**
 *  初始化城市控制器
 *
 *  @param dataArray 城市数组, 数组的格式是有要求的 需要时数组中的元素仍然是ZJCitiesGroup

 */
- (instancetype)initWithDataArray:(NSArray<ZJCitiesGroup *> *)dataArray;
- (void)setupCityCellClickHandler:(ZJCitySelectedHandler)citySelectedHandler;

@end

