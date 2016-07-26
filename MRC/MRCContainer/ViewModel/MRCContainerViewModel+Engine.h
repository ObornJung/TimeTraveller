//
//  MRCContainerViewModel+Engine.h
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCWebCommand.h"
#import "MRCOperation.h"
#import "MRCContainerViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

extern NSString * const kMRCReloadActionKey;
extern NSString * const kMRCReloadParamsKey;

typedef MRCOperation * (^FFMRCCompletionBlock)(BOOL isSuccess, id model, NSError * error);

@interface MRCContainerViewModel (Engine)
/**
 *    input:@{kFFMRCReloadActionKey:MRCReloadAction, kFFMRCReloadParamsKey:params} || params
 */
@property (nonatomic, strong, readonly) MRCWebCommand   * reloadCommand;
/**
 *    input:@{kFFMRCReloadActionKey:MRCReloadAction, kFFMRCReloadParamsKey:params} || params
 */
@property (nonatomic, strong, readonly) MRCWebCommand   * loadMoreCommand;

- (RACSignal *)reloadAllWithParams:(id)params indicator:(BOOL)show;
- (RACSignal *)reloadSections:(NSIndexSet *)sections params:(id)params indicator:(BOOL)show;
- (RACSignal *)reloadItems:(NSArray<NSIndexPath *> *)items params:(id)params indicator:(BOOL)show;
- (RACSignal *)loadMoreWithParams:(id)params indicator:(BOOL)show;

#pragma subsclass property
/**
 *    loadMoreCommand的使能signal，默认为nil
 */
@property (nonatomic, strong, readonly) RACSignal   * hasMoreSignal;
/**
 *    reloadCommand的使能signal，默认为nil
 */
@property (nonatomic, strong, readonly) RACSignal   * canReloadSignal;

#pragma subclass methods
/**
 *    添加loadMoreCommand的数据接口，默认实现：调用appendDataSource:
 *
 *    @param data data
 */
- (void)appendMoreData:(MRCContainerDataSourceType *)data;
/**
 *    reload接口，需要子类化具体的服务器请求
 *
 *    @param params     参数
 *    @param completion 结果回调block
 */
- (void)reloadWithParams:(id)params completion:(FFMRCCompletionBlock)completion;
/**
 *    reload sections data，需要子类化具体的服务器请求
 *
 *    @param sections   should reload sections
 *    @param params     参数
 *    @param completion 结果回调block
 */
- (void)reloadSections:(NSIndexSet *)sections
                params:(id)params
            completion:(MRCOperation * (^)(BOOL isSuccess, NSDictionary<NSNumber *, NSArray<MRCModel *> *> * sections, NSError * error))completion;
/**
 *    reload items data，需要子类化具体的服务器请求
 *
 *    @param items      indexPaths of reload items
 *    @param params     参数
 *    @param completion 结果回调block
 */
- (void)reloadItems:(NSArray<NSIndexPath *> *)items
             params:(id)params
         completion:(MRCOperation * (^)(BOOL isSuccess, NSDictionary<NSIndexPath *, MRCModel *> * models, NSError * error))completion;
/**
 *    load more接口，需要子类化具体的服务器请求
 *
 *    @param params     参数
 *    @param completion 结果回调block
 */
- (void)loadMoreWithParams:(id)params completion:(FFMRCCompletionBlock)completion;
/**
 *    取消reload请求接口，需要子类化实现
 */
- (void)cancelReload;
/**
 *    取消load more请求接口，需要子类化实现
 */
- (void)cancelLoadMore;
/**
 *    数据解析接口，需要子类化实现
 *
 *    @param data 输入数据
 *
 *    @return 解析好的data source
 */
- (MRCContainerDataSourceType *)parse:(id)data;

@end
