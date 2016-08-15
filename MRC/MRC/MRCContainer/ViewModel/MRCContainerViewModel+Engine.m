//
//  MRCContainerViewModel+Engine.m
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import <objc/runtime.h>
#import "MRCAction.h"
#import "MRCAction+Private.h"
#import "MRCOperation+Private.h"
#import "MRCContainerViewModel+Engine.h"
#import "MRCContainerViewModel+Private.h"
#import "MRCContainerViewModel+Operations.h"

NSString * const kMRCReloadActionKey      = @"action";
NSString * const kMRCReloadParamsKey      = @"params";

#pragma - MRCContainerViewModel (Engine)

@implementation MRCContainerViewModel (Engine)
@dynamic hasMoreSignal;
@dynamic canReloadSignal;

- (MRCWebCommand *)reloadCommand {
    MRCWebCommand * _reloadCommand = objc_getAssociatedObject(self, _cmd);
    if (!_reloadCommand) {
        @weakify(self);
        _reloadCommand = [[MRCWebCommand alloc] initWithEnabled:self.canReloadSignal signalBlock:^RACSignal *(id input) {
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @weakify(subscriber);
                id params = input;
                MRCAction * reloadAction = nil;
                if ([input isKindOfClass:NSDictionary.class]) {
                    params = input[kMRCReloadParamsKey];
                    reloadAction = input[kMRCReloadActionKey];
                }
                
                MRCOperation * operation = [MRCOperation operationWithAction:reloadAction];
                /**
                 *    通过线程参数透传action默认设置项
                 */
                if (reloadAction) {
                    operation.doNext = ^(MRCAction * action) {
                        [MRCAction setActionTemplete:action];
                    };
                    operation.didNext = ^(MRCAction * action) {
                        [MRCAction setActionTemplete:nil];
                    };
                }
                
                MRCActionSubType reloadType = (reloadAction && MRCActionTypeReload == reloadAction.type) ? reloadAction.subType : MRCActionSubTypeAll;
                switch (reloadType) {
                    case MRCActionSubTypeItems: {     ///< reload items
                        [self_weak_ reloadItems:reloadAction.items params:params completion:^MRCOperation *(BOOL isSuccess, NSDictionary<NSIndexPath *, MRCModel *> * models, NSError *error) {
                            @strongify(subscriber);
                            if (isSuccess) {
                                [operation asyncExecute:^(MRCAction *action) {
                                    @strongify(self);
                                    [self reloadItemsWithData:models];
                                }];
                                [subscriber sendNext:models];
                                [subscriber sendCompleted];
                            } else {
                                [subscriber sendError:error];
                            }
                            return operation;
                        }];
                        break;
                    }
                    case MRCActionSubTypeSections: {  ///< reload items
                        [self_weak_ reloadSections:reloadAction.sections params:params completion:^MRCOperation *(BOOL isSuccess, NSDictionary<NSNumber *,  NSArray<MRCModel *> *> * sections, NSError *error) {
                            @strongify(subscriber);
                            if (isSuccess) {
                                [operation asyncExecute:^(MRCAction *action) {
                                    @strongify(self);
                                    [self reloadSectionsWithData:sections];
                                }];
                                [subscriber sendNext:sections];
                                [subscriber sendCompleted];
                            } else {
                                [subscriber sendError:error];
                            }
                            return operation;
                        }];
                        break;
                    }
                    default: {  ///< reload all
                        [self_weak_ reloadWithParams:params completion:^MRCOperation *(BOOL isSuccess, id model, NSError *error)  {
                            @strongify(subscriber);
                            if (isSuccess) {
                                [operation asyncExecute:^(MRCAction * action) {
                                    @strongify(self);
                                    [self reloadDataSource:[self parse:model]];
                                }];
                                [subscriber sendNext:model];
                                [subscriber sendCompleted];
                            } else {
                                [subscriber sendError:error];
                            }
                            return operation;
                        }];
                        break;
                    }
                }
                return [RACDisposable disposableWithBlock:^{
                    @strongify(self);
                    [self cancelReload];
                }];
            }] takeUntil:self_weak_.rac_willDeallocSignal];
        }];
        objc_setAssociatedObject(self, _cmd, _reloadCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _reloadCommand;
}

- (MRCWebCommand *)loadMoreCommand {
    MRCWebCommand * _loadMoreCommand = objc_getAssociatedObject(self, _cmd);
    if (!_loadMoreCommand) {
        @weakify(self);
        _loadMoreCommand = [[MRCWebCommand alloc] initWithEnabled:self.hasMoreSignal signalBlock:^RACSignal *(id input) {
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @weakify(subscriber);
                id params = input;
                MRCAction * loadAction = nil;
                if ([input isKindOfClass:NSDictionary.class]) {
                    params = input[kMRCReloadParamsKey];
                    loadAction = input[kMRCReloadActionKey];
                }
                [self_weak_ loadMoreWithParams:input completion:^MRCOperation *(BOOL isSuccess, id model, NSError *error) {
                    MRCOperation * operation = [MRCOperation operationWithAction:loadAction];
                    /**
                     *    通过线程参数透传action默认设置项
                     */
                    if (loadAction) {
                        operation.doNext = ^(MRCAction * action) {
                            [MRCAction setActionTemplete:action];
                        };
                        operation.didNext = ^(MRCAction * action) {
                            [MRCAction setActionTemplete:nil];
                        };
                    }
                    @strongify(subscriber);
                    if (isSuccess) {
                        [operation asyncExecute:^(MRCAction * action) {
                            @strongify(self);
                            [self appendMoreData:[self parse:model]];
                        }];
                        [subscriber sendNext:model];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:error];
                    }
                    return operation;
                }];
                return [RACDisposable disposableWithBlock:^{
                    @strongify(self);
                    [self cancelLoadMore];
                }];
            }] takeUntil:self_weak_.rac_willDeallocSignal];
        }];
        objc_setAssociatedObject(self, _cmd, _loadMoreCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _loadMoreCommand;
}

- (RACSignal *)reloadAllWithParams:(id)params indicator:(BOOL)show {
    return [self reloadAction:[MRCAction actionOfReloadAll] withParams:params showLoading:show];
}

- (RACSignal *)reloadSections:(NSIndexSet *)sections params:(id)params indicator:(BOOL)show {
    return [self reloadAction:[MRCAction actionOfReloadSections:sections] withParams:params showLoading:show];
}

- (RACSignal *)reloadItems:(NSArray<NSIndexPath *> *)items params:(id)params indicator:(BOOL)show {
    return [self reloadAction:[MRCAction actionOfReloadItems:items] withParams:params showLoading:show];
}

- (RACSignal *)reloadAction:(MRCAction *)action withParams:(id)params showLoading:(BOOL)show {
    NSMutableDictionary * actionDic = [NSMutableDictionary dictionaryWithCapacity:2];
    action ? actionDic[kMRCReloadActionKey] = action : nil;
    params ? actionDic[kMRCReloadParamsKey] = params : nil;
    return [self.reloadCommand execute:actionDic.count>0?[actionDic copy]:params indicator:show];
}

- (RACSignal *)loadMoreWithParams:(id)params indicator:(BOOL)show {
    NSMutableDictionary * actionDic = [NSMutableDictionary dictionaryWithCapacity:2];
    actionDic[kMRCReloadActionKey] = [MRCAction actionOfReloadAll];
    params ? actionDic[kMRCReloadParamsKey] = params : nil;
    return [self.loadMoreCommand execute:[actionDic copy] indicator:show];
}

#pragma mark subsclass property

- (RACSignal *)hasMoreSignal {
    return nil;
}

- (RACSignal *)canReloadSignal {
    return nil;
}

#pragma subclass methods

- (void)appendMoreData:(MRCContainerDataSourceType *)data {
    [self appendDataSource:data];
}

- (void)reloadWithParams:(id)params completion:(FFMRCCompletionBlock)completion {
    if (completion) {
        completion(NO, nil, nil);
    }
}

- (void)reloadSections:(NSIndexSet *)sections
                params:(id)params
            completion:(MRCOperation * (^)(BOOL isSuccess, NSDictionary<NSNumber *, NSArray<MRCModel *> *> * sections, NSError * error))completion {
    if (completion) {
        completion(NO, nil, nil);
    }
}

- (void)reloadItems:(NSArray<NSIndexPath *> *)items
             params:(id)params
         completion:(MRCOperation * (^)(BOOL isSuccess, NSDictionary<NSIndexPath *, MRCModel *> * models, NSError * error))completion {
    if (completion) {
        completion(NO, nil, nil);
    }
}

- (void)loadMoreWithParams:(id)params completion:(FFMRCCompletionBlock)completion {
    if (completion) {
        completion(NO, nil, nil);
    }
}

- (void)cancelReload { }

- (void)cancelLoadMore { }

- (MRCContainerDataSourceType *)parse:(id)data { return nil; }

@end
