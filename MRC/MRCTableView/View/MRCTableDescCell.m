//
//  MRCTableDescCell.m
//  MRC
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "UIColor+MRC.h"
#import "MRCDescModel.h"
#import "MRCTableDescCell.h"

@interface MRCTableDescCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;

@end


@implementation MRCTableDescCell

#pragma mark - FFMRCTableViewCellProtocol

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForModel:(MRCModel *)model {
    return 40.0f;
}

- (void)renderWithModel:(__kindof MRCModel *)model {
    if ([model isKindOfClass:[MRCDescModel class]]) {
        MRCDescModel * descModel = model;
        self.titleLabel.text = descModel.title;
        self.descLabel.text  = descModel.describe;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([self.titleLabel sizeThatFits:CGSizeZero].width);
        }];
    }
}

#pragma mark -

- (void)setupViews {
    [super setupViews];
    self.contentView.clipsToBounds   = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:({
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel;
    })];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:({
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.font = [UIFont systemFontOfSize:15.0f];
        _descLabel.textColor = [UIColor mrc_colorWithRGB:0x333333];
        _descLabel;
    })];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-10);
        make.centerY.equalTo(_titleLabel);
        make.leading.equalTo(_titleLabel.mas_trailing).offset(10);
    }];
}

@end
