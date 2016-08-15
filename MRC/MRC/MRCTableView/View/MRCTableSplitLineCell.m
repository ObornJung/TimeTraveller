//
//  MRCTableSplitLineCell.m
//  MRC
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCLine.h"
#import "MRCDefines.h"
#import "MRCSplitLineModel.h"
#import "MRCTableSplitLineCell.h"

@interface MRCTableSplitLineCell ()

@property (nonatomic, strong) MRCLine    * splitLine;

@end

@implementation MRCTableSplitLineCell

#pragma mark - Override

- (void)setupViews {
    [super setupViews];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:({
        _splitLine = [MRCLine lineWithType:MRCLineTypeLine color:[UIColor grayColor] width:0.5];
        _splitLine;
    })];
    [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

#pragma mark - FFMRCTableViewCellProtocol

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForModel:(MRCModel *)model {
    if ([model isKindOfClass:[MRCSplitLineModel class]]) {
        return ((MRCSplitLineModel *)model).width;
    }
    return [super tableView:tableView rowHeightForModel:model];
}

- (void)renderWithModel:(__kindof MRCModel *)model {
    if ([model isKindOfClass:[MRCSplitLineModel class]]) {
        MRCSplitLineModel * splitLineModel = (MRCSplitLineModel *)model;
        switch (splitLineModel.style) {
            case MRCSplitLineStyleDotLine: {
                _splitLine.type  = MRCLineTypeDot;
                break;
            }
            case MRCSplitLineStyleDashLine: {
                _splitLine.type  = MRCLineTypeDash;
                break;
            }
            default: {
                _splitLine.type  = MRCSplitLineStyleLine;
                break;
            }
        }
        _splitLine.width = splitLineModel.width;
        _splitLine.color = splitLineModel.color;
        [_splitLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(splitLineModel.insets.left);
            make.trailing.equalTo(splitLineModel.insets.right);
        }];
    }
}

@end