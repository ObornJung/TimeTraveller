//
//  MRCContainerViewModel+Private.h
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCContainerViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MRCContainerViewModel (Private)

- (BOOL)_isKindOfDataSource:(MRCContainerDataSourceType *)dataSource;

- (BOOL)_isKindOfSectionData:(MRCContainerSectionType *)sectionData;

@end

@interface MRCContainerViewModel () {
    @private RACSubject * _dataUpdatedSignal;
}

@property (nonatomic, strong) NSMutableArray<NSMutableArray<MRCModel *> *>    * dataSource;

@end