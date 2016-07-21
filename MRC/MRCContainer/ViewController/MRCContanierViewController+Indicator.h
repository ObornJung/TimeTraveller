//
//  MRCContanierViewController+Indicator.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCContanierViewController.h"

@interface MRCContanierViewController (Indicator)

/**
 *    控制显示空白页面
 *
 *    @param show show or hidden
 */
- (void)showEmptyView:(BOOL)show;

- (void)reloadIndicator:(BOOL)loading;

- (void)loadMoreIndicator:(BOOL)loading;

- (void)enableLoadMoreIndicator:(BOOL)enable;

- (void)errorHandler:(NSError *)error;

@end
