//
//  MRCTableDescCell.h
//  MRC
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewCell.h"

@interface MRCTableDescCell : MRCTableViewCell

@property (nonatomic, strong, readonly) UILabel * titleLabel;
@property (nonatomic, strong, readonly) UILabel * descLabel;

@end
