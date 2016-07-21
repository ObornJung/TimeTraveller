//
//  MRCContanierViewController+Action.m
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCContanierViewController+Action.h"

@implementation MRCContanierViewController (Action)

- (void)executeAction:(MRCAction *)action {
    switch (action.type) {
        case MRCActionTypeReload: {
            switch (action.subType) {
                case MRCActionSubTypeAll: {
                    [self reloadContentView:action.completion];
                    break;
                }
                case MRCActionSubTypeItems: {
                    [self reloadItemsAtIndexPaths:action.items animated:action.animated completion:action.completion];
                    break;
                }
                case MRCActionSubTypeSections: {
                    [self reloadSections:action.sections animated:action.animated completion:action.completion];
                    break;
                }
            }
            break;
        }
        case MRCActionTypeInsert: {
            switch (action.subType) {
                    
                case MRCActionSubTypeItems: {
                    [self insertItemsAtIndexPaths:action.items animated:action.animated completion:action.completion];
                    break;
                }
                case MRCActionSubTypeSections: {
                    [self insertSections:action.sections animated:action.animated completion:action.completion];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case MRCActionTypeDelete: {
            switch (action.subType) {
                case MRCActionSubTypeItems: {
                    [self deleteItemsAtIndexPaths:action.items animated:action.animated completion:action.completion];
                    break;
                }
                case MRCActionSubTypeSections: {
                    [self deleteSections:action.sections animated:action.animated completion:action.completion];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case MRCActionTypeMove: {
            switch (action.subType) {
                case MRCActionSubTypeItems: {
                    if ([action.context isKindOfClass:[NSDictionary class]]) {
                        NSDictionary * context = action.context;
                        [self moveItemAtIndexPath:context[@"from"] toIndexPath:context[@"to"] animated:action.animated completion:action.completion];
                    }
                    break;
                }
                case MRCActionSubTypeSections: {
                    if ([action.context isKindOfClass:[NSDictionary class]]) {
                        NSDictionary * context = action.context;
                        NSNumber * from = context[@"from"];
                        NSNumber * to = context[@"to"];
                        [self moveSection:from.integerValue toSection:to.integerValue animated:action.animated completion:action.completion];
                    }
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case MRCActionTypeCustom: {
            [self customAction:action];
            break;
        }
    }
    MRCLog(@"MRC update table %@\n%@", self, action);
}

- (void)reloadContentView:(void (^)(BOOL))completion {
    
}

- (void)reloadSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    
}

- (void)insertSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    
}

- (void)deleteSections:(NSIndexSet *)sections
              animated:(BOOL)animated
            completion:(void (^)(BOOL))completion {
    
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                       animated:(BOOL)animated
                     completion:(void (^)(BOOL))completion {
    
}

- (void)moveSection:(NSInteger)section
          toSection:(NSInteger)newSection
           animated:(BOOL)animated
         completion:(void (^)(BOOL))completion {
    
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath
                   animated:(BOOL)animated
                 completion:(void (^)(BOOL))completion {
    
}

- (void)customAction:(MRCAction *)action {
    
}

@end
