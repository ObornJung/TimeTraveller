//
//  MRCContainerViewModel+Operations.h
//  FastFood
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCContainerViewModel.h"

@interface MRCContainerViewModel (Operations)

- (BOOL)reloadDataSource:(MRCContainerDataSourceType *)dataSource;

- (BOOL)reloadItemsWithData:(NSDictionary<NSIndexPath *, MRCModel *> *)models;

- (BOOL)reloadSectionsWithData:(NSDictionary<NSNumber *, NSArray<MRCModel *> *> *)sections;

- (BOOL)appendDataSource:(MRCContainerDataSourceType *)dataSource;

/**
 *    在对应section后面添加多个model
 */
- (BOOL)appendModels:(NSArray<MRCModel  *> *)modelList atSection:(NSInteger)section;

- (BOOL)insertModel:(MRCModel *)model atIndexPath:(NSIndexPath *)indexPath;

- (BOOL)insertSections:(NSArray<MRCContainerSectionType *> *)sections atSection:(NSInteger)section;

- (BOOL)insertSections:(NSArray<MRCContainerSectionType *> *)sections atSections:(NSIndexSet *)indexSet;

- (BOOL)deleteModelAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)deleteSections:(NSIndexSet *)sections;

- (BOOL)moveSection:(NSInteger)section toSection:(NSInteger)newSection;

- (BOOL)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

/**
 *    默认取indexPath.section, indexPath.row
 */
- (NSInteger)indexOfIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)sectionOfIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathWithIndex:(NSInteger)index inSection:(NSInteger)section;

@end
