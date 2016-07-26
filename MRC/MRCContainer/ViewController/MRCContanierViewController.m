//
//  MRCContanierViewController.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCContanierViewController.h"
#import "MRCContanierViewController+Action.h"
#import "MRCContanierViewController+Indicator.h"

@implementation MRCContanierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self bindViewModel];
}
- (void)setupViews {}

- (void)bindViewModel {
    @weakify(self);
    /**
     *    绑定reload执行态，更新刷新状态
     */
    [self.viewModel.reloadCommand.loadingIndicator subscribeNext:^(NSNumber * executing) {
        @strongify(self);
        [self reloadIndicator:executing.boolValue];
    }];
    [self.viewModel.reloadCommand.errorIndicator subscribeNext:^(NSError * error) {
        @strongify(self);
        [self errorHandler:error];
    }];
    /**
     *    绑定loadmore执行态，更新footer的刷新状态
     */
    [self.viewModel.loadMoreCommand.loadingIndicator subscribeNext:^(NSNumber * executing) {
        @strongify(self);
        [self loadMoreIndicator:executing.boolValue];
    }];
    /**
     *    绑定loadmore enable状态
     */
    [self.viewModel.hasMoreSignal subscribeNext:^(NSNumber * enable) {
        @strongify(self);
        [self enableLoadMoreIndicator:enable.boolValue];
    }];
    [self.viewModel.loadMoreCommand.errorIndicator subscribeNext:^(NSError * error) {
        @strongify(self);
        [self errorHandler:error];
    }];
    /**
     *    bind update view action
     */
    [self.viewModel.dataUpdatedSignal subscribeNext:^(MRCAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self errorHandler:nil];
            [self executeAction:action];
            [self showEmptyView:self.viewModel.isEmpty];
        });
    }];
}

- (RACSignal *)reloadData {
    return [self.viewModel reloadAllWithParams:nil indicator:YES];
}

- (RACSignal *)loadMoreData {
    return [self.viewModel loadMoreWithParams:nil indicator:YES];
}

#pragma mark MRCCellMappingProtocol

- (Class)cellClassForModel:(MRCModel *)model {
    return nil;
}

- (Class)headerClassForModel:(MRCModel *)model {
    return nil;
}

- (Class)footerClassForModel:(MRCModel *)model {
    return nil;
}

@end
