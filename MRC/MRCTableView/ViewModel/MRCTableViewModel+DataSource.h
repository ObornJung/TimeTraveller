//
//  MRCTableViewModel+DataSource.h
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTableViewModel (DataSource)<UITableViewDataSource>

/**
 *  获取indexPath对应的cell高度
 *
 *  @param tableView tableView
 *  @param indexPath indexPath
 *
 *  @return indexPath对应的cell高度
 */
- (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
