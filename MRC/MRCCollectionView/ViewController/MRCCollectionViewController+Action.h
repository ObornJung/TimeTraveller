//
//  MRCCollectionViewController+Action.h
//  FastFood
//
//  Created by Oborn.Jung on 16/5/5.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewController.h"

@interface MRCCollectionViewController (Action)

- (void)reloadContentView:(void (^)(BOOL))completion;
- (void)reloadSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion;
- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion;

- (void)insertSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion;
- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion;

- (void)deleteSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion;
- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion;

- (void)moveSection:(NSInteger)section
          toSection:(NSInteger)newSection
           animated:(BOOL)animated
         completion:(void (^)(BOOL))completion;
- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath
                   animated:(BOOL)animated
                 completion:(void (^)(BOOL))completion;

- (void)customAction:(MRCAction *)action;

@end
