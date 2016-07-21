//
//  MRCTableViewController.m
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableComponent.h"
#import "MRCTableViewController.h"
#import "MRCTableViewModel+DataSource.h"

@interface MRCTableViewController ()

@end

@implementation MRCTableViewController
@dynamic viewModel;

- (void)setViewModel:(MRCTableViewModel *)viewModel {
    viewModel.cellFactory = self;
    viewModel.cellActionDelegate = self;
    self.tableView.dataSource = viewModel;
    [super setViewModel:viewModel];
}

- (void)setupViews {
    [self.view addSubview:({
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delaysContentTouches = NO;
        _tableView.dataSource = self.viewModel;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView;
    })];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)bindViewModel {
    RAC(self, title) = [RACObserve(self.viewModel, title) distinctUntilChanged];
    [super bindViewModel];
}

#pragma mark - MRCCellMappingProtocol

- (Class)cellClassForModel:(MRCModel *)model {
    static NSDictionary * cellMapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellMapping = @{kMRCDescModelTag : [MRCTableDescCell class],
                        kMRCSplitLineTag : [MRCTableSplitLineCell class],
                        };
    });
    return cellMapping[model.tag];
}

@end
