//
//  MRCTableViewController+Action.m
//  FastFood
//
//  Created by Oborn.Jung on 16/4/29.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableViewController+Action.h"

@implementation MRCTableViewController (Action)

- (void)reloadContentView:(void (^)(BOOL))completion {
    [self.tableView reloadData];
    completion ? completion(YES) : nil;
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (indexPaths.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:indexPaths
                              withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)reloadSections:(NSIndexSet *)sections  animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (sections.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView reloadSections:sections withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)insertSections:(NSIndexSet *)sections animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (sections.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView insertSections:sections withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (indexPaths.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)deleteSections:(NSIndexSet *)sections animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (sections.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationLeft : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView deleteSections:sections withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated completion:(void (^)(BOOL))completion; {
    if (indexPaths.count > 0) {
        UITableViewRowAnimation animation = animated ? UITableViewRowAnimationLeft : UITableViewRowAnimationNone;
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (section != newSection) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView moveSection:section toSection:newSection];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (![indexPath isEqual:newIndexPath]) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        completion ? [CATransaction setCompletionBlock:^{ completion(YES); }] : nil;
        [self.tableView beginUpdates];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
        [self.tableView endUpdates];
        [CATransaction commit];
    }
}

- (void)customAction:(MRCAction *)action {
    
}


@end
