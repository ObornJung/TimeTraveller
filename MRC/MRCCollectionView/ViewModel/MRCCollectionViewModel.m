//
//  MRCCollectionViewModel.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewModel.h"

@interface MRCCollectionViewModel()

@property (strong, nonatomic) NSMutableDictionary<NSString *, id> * methodBlocks;

@end

@implementation MRCCollectionViewModel

- (NSMutableDictionary<NSString *, id> *)methodBlocks {
    if (!_methodBlocks) {
        _methodBlocks = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _methodBlocks;
}

#pragma mark - Indexpath construction

- (NSInteger)indexOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item;
}

- (NSInteger)sectionOfIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section;
}

- (NSIndexPath *)indexPathWithIndex:(NSInteger)index inSection:(NSInteger)section {
    return [NSIndexPath indexPathForItem:index inSection:section];
}

#pragma mark -

- (void)implementMethod:(SEL)selector withBlock:(id)block {
    NSCAssert(selector, @"Attempt to implement or remove NULL selector");
    NSString * selString = NSStringFromSelector(selector);
    @synchronized(self) {
        if (!block) {
            [self.methodBlocks removeObjectForKey:selString];
        } else {
            self.methodBlocks[selString] = block;
        }
    }
}

- (id)blockImplementationForMethod:(SEL)selector {
    NSCAssert(selector, @"Attempt to implement or remove NULL selector");
    NSString * selString = NSStringFromSelector(selector);
    @synchronized(self) {
        return self.methodBlocks[selString];
    }
}

@end
