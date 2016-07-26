//
//  MRCTableViewCell.h
//  MRC
//
//  Created by Oborn.Jung on 16/3/28.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCell.h"
#import <UIKit/UIKit.h>

@protocol MRCTableViewCellProtocol <MRCReusableViewProtocol>

@optional

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForModel:(MRCModel *)model;

@end

@interface MRCTableViewCell : UITableViewCell <MRCTableViewCellProtocol>

@property (nonatomic, weak) id<MRCCellActionProtocol>   actionDelegate;

- (void)setupViews;

@end