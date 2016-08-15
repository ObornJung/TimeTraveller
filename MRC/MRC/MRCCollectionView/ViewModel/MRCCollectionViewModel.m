//
//  MRCCollectionViewModel.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewModel.h"
#import "MRCContainerViewModel+Engine.h"

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

#pragma mark - override

- (RACSignal *)reloadSections:(NSIndexSet *)sections params:(id)params indicator:(BOOL)show {
    NSMutableDictionary * actionDic = [NSMutableDictionary dictionaryWithCapacity:2];
    MRCAction * action = [MRCAction actionOfReloadSections:sections];
    action.animated = NO;
    action ? actionDic[kMRCReloadActionKey] = action : nil;
    params ? actionDic[kMRCReloadParamsKey] = params : nil;
    return [self.reloadCommand execute:actionDic.count>0?[actionDic copy]:params indicator:show];
}

- (RACSignal *)reloadItems:(NSArray<NSIndexPath *> *)items params:(id)params indicator:(BOOL)show {
    NSMutableDictionary * actionDic = [NSMutableDictionary dictionaryWithCapacity:2];
    MRCAction * action = [MRCAction actionOfReloadItems:items];
    action.animated = NO;
    action ? actionDic[kMRCReloadActionKey] = action : nil;
    params ? actionDic[kMRCReloadParamsKey] = params : nil;
    return [self.reloadCommand execute:actionDic.count>0?[actionDic copy]:params indicator:show];
}

- (RACSignal *)loadMoreWithParams:(id)params indicator:(BOOL)show {
    NSMutableDictionary * actionDic = [NSMutableDictionary dictionaryWithCapacity:2];
    MRCAction * action = [MRCAction actionOfReloadAll];
    action.animated = NO;
    action ? actionDic[kMRCReloadActionKey] = action : nil;
    params ? actionDic[kMRCReloadParamsKey] = params : nil;
    return [self.loadMoreCommand execute:actionDic.count>0?[actionDic copy]:params indicator:show];
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
