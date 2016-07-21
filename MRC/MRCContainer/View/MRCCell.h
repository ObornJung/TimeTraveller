//
//  MRCCell.h
//  FastFood
//
//  Created by Oborn.Jung on 16/5/5.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCModel.h"
#import <UIKit/UIKit.h>

@protocol MRCCellMappingProtocol <NSObject>

@required
- (Class)cellClassForModel:(MRCModel *)model;

@optional
- (Class)headerClassForModel:(MRCModel *)model;
- (Class)footerClassForModel:(MRCModel *)model;

@end

@protocol MRCCellActionProtocol <NSObject>

@optional
- (void)cell:(UIView *)cell action:(NSInteger)type context:(id)context;

@end

@protocol MRCReusableViewProtocol <NSObject>

@optional

+ (NSString *)mrc_reuseIdentifier;

- (void)renderWithModel:(__kindof MRCModel *)model;

- (void)setActionDelegate:(id<MRCCellActionProtocol>)delegate;

@end


