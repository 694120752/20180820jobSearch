//
//  THRPhotoAction.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/19.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THRPhotoDelegate <NSObject>

/*
 asset为上一次的照片选择情况 目前必传
 **/
- (void)pickResult:(NSArray*)photoArray andAssert:(NSArray *)asset;
@end

@interface THRPhotoAction : NSObject
- (instancetype)initWithVc:(UIViewController<THRPhotoDelegate> *)vc andPhotoCount:(NSUInteger)count andLastAsset:(NSArray *)selectedAssets;

- (void)showAlertVc;

@end
