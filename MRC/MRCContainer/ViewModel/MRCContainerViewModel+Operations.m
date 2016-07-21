//
//  MRCContainerViewModel+Operations.m
//  FastFood
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCAction.h"
#import "NSArray+MRC.h"
#import "MRCSectionModel.h"
#import "NSDictionary+MRC.h"
#import "MRCContainerViewModel+Private.h"
#import "MRCContainerViewModel+Operations.h"

#pragma mark - MRCContainerViewModel (Operations)

@implementation MRCContainerViewModel (Operations)

- (BOOL)reloadDataSource:(MRCContainerDataSourceType *)dataSource {
    if ([self _isKindOfDataSource:dataSource]) {
        self.dataSource = [dataSource mrc_mutableDeepCopy];
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfReloadAll]];
        return YES;
    }
    return NO;
}

- (BOOL)reloadItemsWithData:(NSDictionary<NSIndexPath *, MRCModel *> *)models {
    NSMutableArray<NSIndexPath *> * reloadItems = [NSMutableArray arrayWithCapacity:models.count];
    for (NSIndexPath * indexPath in models.allKeys) {
        NSInteger section = [self sectionOfIndexPath:indexPath];
        NSInteger index = [self indexOfIndexPath:indexPath];
        if (section < self.dataSource.count && index < self.dataSource[section].count) {
            self.dataSource[section][index] = models[indexPath];
            [reloadItems addObject:indexPath];
        }
    }
    if (reloadItems.count > 0) {
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfReloadItems:[reloadItems copy]]];
    }
    return reloadItems.count > 0;
}

- (BOOL)reloadSectionsWithData:(NSDictionary<NSNumber *,  NSArray<MRCModel *> *> *)sections {
    NSMutableIndexSet * reloadSections = [[NSMutableIndexSet alloc] init];
    for (NSNumber * section in sections.allKeys) {
        NSUInteger index = section.unsignedIntegerValue;
        if (index < self.dataSource.count) {
            self.dataSource[index] = [sections[section] mutableCopy];
            [reloadSections addIndex:index];
        }
    }
    if (reloadSections.count > 0) {
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfReloadSections:reloadSections]];
    }
    return reloadSections.count > 0;
}

- (BOOL)appendDataSource:(MRCContainerDataSourceType *)dataSource {
    if ([self _isKindOfDataSource:dataSource]) {
        [self.dataSource addObjectsFromArray:[dataSource mrc_mutableDeepCopy]];
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfReloadAll]];
        return YES;
    }
    return NO;
}

- (BOOL)appendModels:(NSArray<MRCModel *> *)modelList atSection:(NSInteger)section {
    if (modelList && section < self.dataSource.count && [self _isKindOfSectionData:modelList]) {
        NSMutableArray<MRCModel *> * sectionModels = self.dataSource[section];
        NSUInteger lastrow = sectionModels.count;
        [sectionModels addObjectsFromArray:modelList];
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for(int i = 0;i<modelList.count;i++){
            [arr addObject:[NSIndexPath indexPathForItem:(lastrow+i) inSection:section]];
        }
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfInsertItems:arr]];
        return YES;
    }
    return NO;
}

- (BOOL)insertModel:(MRCModel *)model atIndexPath:(NSIndexPath *)indexPath  {
    NSInteger section = [self sectionOfIndexPath:indexPath];
    if (model && section < self.dataSource.count) {
        NSInteger index = [self indexOfIndexPath:indexPath];
        NSMutableArray<MRCModel *> * sectionModels = self.dataSource[section];
        index = index < sectionModels.count ? index : sectionModels.count;
        [sectionModels insertObject:model atIndex:index];
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfInsertItems:@[indexPath]]];
        return YES;
    }
    return NO;
}

- (BOOL)insertSections:(NSArray<MRCContainerSectionType *> *)sections atSection:(NSInteger)section {
    if ([self _isKindOfDataSource:sections] && sections.count > 0) {
        NSIndexSet * inserSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(section, sections.count)];
        [self insertSections:sections atSections:inserSet];
        return YES;
    }
    return NO;
}

- (BOOL)insertSections:(NSArray<MRCContainerSectionType *> *)sections atSections:(NSIndexSet *)indexSet {
    if ([self _isKindOfDataSource:sections] && sections.count > 0) {
        [self.dataSource insertObjects:[sections mrc_mutableDeepCopy] atIndexes:indexSet];
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfInserSections:indexSet]];
        return YES;
    }
    return NO;
}

- (BOOL)deleteModelAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self indexOfIndexPath:indexPath];
    NSInteger section = [self sectionOfIndexPath:indexPath];
    if (section < self.dataSource.count && index < self.dataSource[section].count) {
        if (self.dataSource[section].count == 1) {
            [self deleteSections:[NSIndexSet indexSetWithIndex:section]];
        } else {
            [self.dataSource[section] removeObjectAtIndex:index];
            [self.dataUpdatedSignal sendNext:[MRCAction actionOfDeleteItems:@[indexPath]]];
        }
        return YES;
    }
    return NO;
}

- (BOOL)deleteSections:(NSIndexSet *)sections {
    if (sections.count == 0) { return NO; }
    [self.dataSource removeObjectsAtIndexes:sections];
    MRCAction * action = [MRCAction actionOfDeleteSections:sections];
    [self.dataUpdatedSignal sendNext:action];
    return YES;
}

- (BOOL)moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (section < self.dataSource.count && newSection < self.dataSource.count) {
        NSMutableArray<MRCModel  *> * sectionData = self.dataSource[section];
        [self.dataSource removeObjectAtIndex:section];
        [self.dataSource insertObject:sectionData atIndex:newSection];
        [self.dataUpdatedSignal sendNext:[MRCAction actionOfMoveSection:section toSection:newSection]];
        return YES;
    }
    return NO;
}

- (BOOL)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    NSInteger fromSection = [self sectionOfIndexPath:indexPath];
    NSInteger toSection = [self sectionOfIndexPath:newIndexPath];
    if (!(toSection < self.dataSource.count)) { return NO; }
    if (!(fromSection < self.dataSource.count)) { return NO; }
    NSInteger fromIndex = [self indexOfIndexPath:indexPath];
    if (!(fromIndex < self.dataSource[fromSection].count)) { return NO; }
    NSInteger toIndex = [self indexOfIndexPath:newIndexPath];
    toIndex = toIndex < self.dataSource[toSection].count ? toIndex : self.dataSource[toSection].count;
    MRCModel * mvModel = self.dataSource[fromSection][fromIndex];
    [self.dataSource[fromSection] removeObjectAtIndex:fromIndex];
    [self.dataSource[toSection] insertObject:mvModel atIndex:toIndex];
    [self.dataUpdatedSignal sendNext:[MRCAction actionOfMoveItemFrom:indexPath to:newIndexPath]];
    return YES;
}

#pragma mark  Indexpath construction

- (NSInteger)indexOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

- (NSInteger)sectionOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section;
}

- (NSIndexPath *)indexPathWithIndex:(NSInteger)index inSection:(NSInteger)section {
    return [NSIndexPath indexPathForRow:index inSection:section];
}

@end
