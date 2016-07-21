//
//  MRCCollectionViewController+Action.m
//  FastFood
//
//  Created by Oborn.Jung on 16/5/5.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewController+Action.h"

@implementation MRCCollectionViewController (Action)

- (void)reloadContentView:(void (^)(BOOL))completion {
    [self.collectionView reloadData];
    completion ? completion(YES) : nil;
}

- (void)reloadSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    if (sections.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView reloadSections:sections];
    [CATransaction commit];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    if (indexPaths.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
    [CATransaction commit];
}

- (void)insertSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    if (sections.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView insertSections:sections];
    [CATransaction commit];
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    if (indexPaths.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView insertItemsAtIndexPaths:indexPaths];
    [CATransaction commit];
}

- (void)deleteSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    if (sections.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView deleteSections:sections];
    [CATransaction commit];
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    if (indexPaths.count == 0) { return; }
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
    [self.collectionView deleteItemsAtIndexPaths:indexPaths];
    [CATransaction commit];
}

- (void)moveSection:(NSInteger)section
          toSection:(NSInteger)newSection
           animated:(BOOL)animated
         completion:(void (^)(BOOL))completion {
    if (section != newSection) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.collectionView moveSection:section toSection:newSection];
        [CATransaction commit];
    }
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath
                   animated:(BOOL)animated
                 completion:(void (^)(BOOL))completion {
    if (![indexPath isEqual:newIndexPath]) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
        [CATransaction commit];
    }
}

- (void)customAction:(MRCAction *)action {
    action.completion ? action.completion(YES) : nil;
}


@end
