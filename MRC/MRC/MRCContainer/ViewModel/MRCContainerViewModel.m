//
//  MRCContainerViewModel.m
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCSectionModel.h"
#import "MRCContainerViewModel.h"
#import "MRCContainerViewModel+Private.h"
#import "MRCContainerViewModel+Operations.h"

@interface MRCContainerViewModel () <MRCCellActionProtocol>

@end

@implementation MRCContainerViewModel

- (RACSubject *)dataUpdatedSignal {
    if (!_dataUpdatedSignal) {
        _dataUpdatedSignal = [RACSubject subject];
        @weakify(self);
        [self.rac_willDeallocSignal subscribeCompleted:^{
            @strongify(self);
            [self.dataUpdatedSignal sendCompleted];
        }];
    }
    return _dataUpdatedSignal;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSInteger)numberOfSections {
    return self.dataSource.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    MRCAssert(section < self.numberOfSections, @"crossing the data source!");
    return section < self.numberOfSections ? self.dataSource[section].count : 0;
}

- (MRCModel *)modelWithIndexPath:(NSIndexPath *)indexPath {
    MRCModel * mrcModel = nil;
    NSInteger index = [self indexOfIndexPath:indexPath];
    NSInteger section = [self sectionOfIndexPath:indexPath];
    MRCAssert(section < self.numberOfSections, @"crossing the data source!");
    MRCAssert(index < [self numberOfItemsInSection:section], @"crossing the section");
    if (section < self.numberOfSections && index < [self numberOfItemsInSection:section]) {
        mrcModel = self.dataSource[section][index];
    }
    return mrcModel;
}

- (nullable __kindof MRCModel *)headerModelWithSection:(NSInteger)section {
    MRCAssert(section < self.numberOfSections, @"crossing the data source!");
    if (section < self.numberOfSections && [self.dataSource[section] respondsToSelector:@selector(headerModel)]) {
        return [(id)self.dataSource[section] headerModel];
    }
    return nil;
}

- (nullable __kindof MRCModel *)footerModelWithSection:(NSInteger)section {
    MRCAssert(section < self.numberOfSections, @"crossing the data source!");
    if (section < self.numberOfSections && [self.dataSource[section] respondsToSelector:@selector(footerModel)]) {
        return [(id)self.dataSource[section] footerModel];
    }
    return nil;
}

- (nullable NSIndexPath *)indexPathWithModel:(nonnull MRCModel *)model {
    NSIndexPath * indexPath = nil;
    for (int section = 0; section < self.dataSource.count; section ++) {
        NSUInteger index = [self.dataSource[section] indexOfObject:model];
        if (index != NSNotFound) {
            indexPath = [self indexPathWithIndex:index inSection:section];
            break;
        }
    }
    return indexPath;
}

- (BOOL)isEmpty {
    return self.dataSource.count == 0;
}

#pragma mark - MRCCellActionProtocol

- (void)cell:(UIView *)cell action:(NSInteger)type context:(id)context {
    if ([self.cellActionDelegate respondsToSelector:@selector(cell:action:context:)]) {
        [self.cellActionDelegate cell:cell action:type context:context];
    }
}

@end
