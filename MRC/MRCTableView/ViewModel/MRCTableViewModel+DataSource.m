//
//  MRCTableViewModel+DataSource.m
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCTableViewCell.h"
#import "MRCTableViewModel+DataSource.h"

@implementation MRCTableViewModel (DataSource)

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<MRCTableViewCellProtocol> * cell = nil;
    MRCModel * model = [self modelWithIndexPath:indexPath];
    Class cellClass = [self.cellFactory cellClassForModel:model];
    MRCAssert([cellClass isSubclassOfClass:UITableViewCell.class], @"Table view cell is invalid!");
    cellClass = cellClass ?: MRCTableViewCell.class;
    NSString * reuseIdentifier = nil;
    if ([cellClass instancesRespondToSelector:@selector(mrc_reuseIdentifier)]) {
        reuseIdentifier = [cellClass mrc_reuseIdentifier];
    } else {
        reuseIdentifier = NSStringFromClass(cellClass);
    }
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    if ([cell respondsToSelector:@selector(setActionDelegate:)]) {
        [cell performSelector:@selector(setActionDelegate:) withObject:self];
    }
    if ([cell respondsToSelector:@selector(renderWithModel:)]) {
        [cell performSelector:@selector(renderWithModel:) withObject:model];
    }
    return cell;
}

#pragma mark -

- (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MRCModel * model = [self modelWithIndexPath:indexPath];
    if (model && MRCModelStatusHidden != model.modelStatus) {
        Class<MRCTableViewCellProtocol> cellClass = [self.cellFactory cellClassForModel:model];
        MRCSuppressMethodAccessWarning({
            if ([cellClass respondsToSelector:@selector(tableView:rowHeightForModel:)]) {
                return [cellClass tableView:nil rowHeightForModel:model];
            }
        });
    }
    return 0.0f;
}

@end
