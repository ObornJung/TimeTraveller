//
//  MRCTableViewCell.m
//  FastFood
//
//  Created by Oborn.Jung on 16/3/28.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewCell.h"

@implementation MRCTableViewCell

+ (NSString *)mrc_reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForModel:(MRCModel *)model {
    return 0.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.clipsToBounds               = YES;
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle              = UITableViewCellSelectionStyleNone;
}

@end
