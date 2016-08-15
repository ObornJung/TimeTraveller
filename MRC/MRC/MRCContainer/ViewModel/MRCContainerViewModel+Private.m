//
//  MRCContainerViewModel+Private.m
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCContainerViewModel+Private.h"

@implementation MRCContainerViewModel (Private)

- (BOOL)_isKindOfDataSource:(MRCContainerDataSourceType *)dataSource {
    if (dataSource && ![dataSource isKindOfClass:[NSArray class]]) {
        MRCAssert(NO, @"data source type error!");
        return NO;
    }
    for (MRCContainerSectionType * sectionModels in dataSource) {
        if (![self _isKindOfSectionData:sectionModels]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)_isKindOfSectionData:(MRCContainerSectionType *)sectionData {
    if (sectionData && ![sectionData isKindOfClass:[NSArray class]]) {
        MRCAssert(NO, @"section data type error!");
        return NO;
    }
    for (MRCModel * model in sectionData) {
        if (![model isKindOfClass:[MRCModel class]]) {
            MRCAssert(NO, @"model data type error!");
            return NO;
        }
    }
    return YES;
}

@end
