//
//  MRCTableViewModel.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTableViewModel ()

@end

@implementation MRCTableViewModel

#pragma mark - Indexpath construction

- (NSInteger)indexOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

- (NSInteger)sectionOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section;
}

- (NSIndexPath *)indexPathWithIndex:(NSInteger)index inSection:(NSInteger)section {
    return [NSIndexPath indexPathForRow:index inSection:section];
}

#pragma mark - MRCCellActionProtocol

- (void)cell:(UIView *)cell action:(NSInteger)type context:(id)context {
    if ([self.cellActionDelegate respondsToSelector:@selector(cell:action:context:)]) {
        [self.cellActionDelegate cell:cell action:type context:context];
    }
}

@end
