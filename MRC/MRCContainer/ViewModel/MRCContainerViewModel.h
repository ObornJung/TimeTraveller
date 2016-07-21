//
//  MRCContainerViewModel.h
//  FastFood
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCell.h"
#import "MRCModel.h"
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NSArray<MRCModel  *>                    MRCContainerSectionType;
typedef NSArray<MRCContainerSectionType *>      MRCContainerDataSourceType;

@interface MRCContainerViewModel : NSObject <MRCCellActionProtocol>

@property (nonatomic, assign, readonly) BOOL                        isEmpty;    ///< Don't support KVO
@property (nonatomic, nonnull,readonly) RACSubject                  * dataUpdatedSignal;
@property (nonatomic, weak, nullable) id<MRCCellMappingProtocol>    cellFactory;
@property (nonatomic, weak, nullable) id<MRCCellActionProtocol>     cellActionDelegate;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (nullable __kindof MRCModel *)modelWithIndexPath:(nonnull NSIndexPath *)indexPath;

- (nullable __kindof MRCModel *)headerModelWithSection:(NSInteger)section;

- (nullable __kindof MRCModel *)footerModelWithSection:(NSInteger)section;

- (nullable NSIndexPath *)indexPathWithModel:(nonnull MRCModel *)model;

@end
