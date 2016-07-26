//
//  MRCCollectionViewModel+DataSource.m
//  MRC
//
//  Created by Oborn.Jung on 16/6/7.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCCollectionCell.h"
#import "MRCCollectionSupplementaryView.h"
#import "MRCCollectionViewModel+DataSource.h"

@interface MRCCollectionViewModel()

@property (strong, nonatomic) NSMutableDictionary<NSString *, id> * methodBlocks;

@end

@implementation MRCCollectionViewModel (DataSource)

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger(^block)(UICollectionView *) = [self blockImplementationForMethod:_cmd];
    if (block) {
        return block(collectionView);
    }
    return self.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger(^block)(UICollectionView *, NSInteger section) = [self blockImplementationForMethod:_cmd];
    if (block) {
        return block(collectionView, section);
    }
    return [self numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = nil;
    UICollectionViewCell*(^block)(UICollectionView *, NSIndexPath *) = [self blockImplementationForMethod:_cmd];
    if (block) {
        cell = block(collectionView, indexPath);
    }
    if (!cell) {
        MRCModel * model = [self modelWithIndexPath:indexPath];
        Class cellClass = [self.cellFactory cellClassForModel:model];
        MRCAssert([cellClass isSubclassOfClass:UICollectionViewCell.class], @"Collection view cell is invalid!");
        cellClass = cellClass ?: MRCCollectionCell.class;
        NSString * reuseIdentifier = nil;
        if ([cellClass instancesRespondToSelector:@selector(mrc_reuseIdentifier)]) {
            reuseIdentifier = [cellClass mrc_reuseIdentifier];
        } else {
            reuseIdentifier = NSStringFromClass(cellClass);
        }
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(setActionDelegate:)]) {
            [cell performSelector:@selector(setActionDelegate:) withObject:self];
        }
        if ([cell respondsToSelector:@selector(renderWithModel:)]) {
            [cell performSelector:@selector(renderWithModel:) withObject:model];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize(^block)(UICollectionView *, UICollectionViewLayout *, NSIndexPath *) = [self blockImplementationForMethod:_cmd];
    if (block) {
        return block(collectionView, collectionViewLayout, indexPath);
    }
    
    MRCModel * model = [self modelWithIndexPath:indexPath];
    if (model) {
        if (MRCModelStatusHidden == model.modelStatus) { return CGSizeZero; }
        Class cellClass = [self.cellFactory cellClassForModel:model];
        MRCSuppressMethodAccessWarning({
            if ([cellClass respondsToSelector:@selector(collectionView:layout:sizeForModel:)]) {
                return [cellClass collectionView:collectionView layout:collectionViewLayout sizeForModel:model];
            }
        });
    }
    return [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class] ? ((UICollectionViewFlowLayout*)collectionViewLayout).itemSize : CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize(^block)(UICollectionView *, UICollectionViewLayout *, NSInteger) = [self blockImplementationForMethod:_cmd];
    if (block) {
        return block(collectionView, collectionViewLayout, section);
    }
    
    MRCModel * model = [self headerModelWithSection:section];
    if (model) {
        if (MRCModelStatusHidden == model.modelStatus) { return CGSizeZero; }
        if ([self.cellFactory respondsToSelector:@selector(headerClassForModel:)]) {
            Class cellClass = [self.cellFactory headerClassForModel:model];
            MRCSuppressMethodAccessWarning({
                if ([cellClass respondsToSelector:@selector(collectionView:layout:sizeForModel:)]) {
                    return [cellClass collectionView:collectionView layout:collectionViewLayout sizeForModel:model];
                }
            });
        }
    }
    return [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class] ? ((UICollectionViewFlowLayout*)collectionViewLayout).headerReferenceSize : CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize(^block)(UICollectionView *, UICollectionViewLayout *, NSInteger) = [self blockImplementationForMethod:_cmd];
    if (block) {
        return block(collectionView, collectionViewLayout, section);
    }
    
    MRCModel * model = [self footerModelWithSection:section];
    if (model) {
        if (MRCModelStatusHidden == model.modelStatus) { return CGSizeZero; }
        if ([self.cellFactory respondsToSelector:@selector(footerClassForModel:)]) {
            Class cellClass = [self.cellFactory footerClassForModel:model];
            MRCSuppressMethodAccessWarning({
                if ([cellClass instancesRespondToSelector:@selector(collectionView:layout:sizeForModel:)]) {
                    return [cellClass collectionView:collectionView layout:collectionViewLayout sizeForModel:model];
                }
            });
        }
    }
    return [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class] ? ((UICollectionViewFlowLayout*)collectionViewLayout).footerReferenceSize : CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * resuableView = nil;
    UICollectionReusableView *(^block)(UICollectionView *, NSString *, NSIndexPath *) = [self blockImplementationForMethod:_cmd];
    if (block) {
        resuableView = block(collectionView, kind, indexPath);
    }
    if (!resuableView) {
        MRCModel * model = nil;
        Class viewClass = nil;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            if ([self.cellFactory respondsToSelector:@selector(headerClassForModel:)]) {
                model = [self headerModelWithSection:indexPath.section];
                viewClass = [self.cellFactory headerClassForModel:model];
            }
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            if ([self.cellFactory respondsToSelector:@selector(footerClassForModel:)]) {
                model = [self footerModelWithSection:indexPath.section];
                viewClass = [self.cellFactory footerClassForModel:model];
            }
        }
        MRCAssert([viewClass isSubclassOfClass:UICollectionReusableView.class], @"Collection supplementary view is invalid!");
        viewClass = viewClass ?: MRCCollectionSupplementaryView.class;
        NSString * reuseIdentifier = nil;
        if ([viewClass respondsToSelector:@selector(mrc_reuseIdentifier)]) {
            reuseIdentifier = [viewClass mrc_reuseIdentifier];
        } else {
            reuseIdentifier = NSStringFromClass(viewClass);
        }
        [collectionView registerClass:viewClass forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
        resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        if ([resuableView respondsToSelector:@selector(setActionDelegate:)]) {
            [resuableView performSelector:@selector(setActionDelegate:) withObject:self];
        }
        if ([resuableView respondsToSelector:@selector(renderWithModel:)]) {
            [resuableView performSelector:@selector(renderWithModel:) withObject:model];
        }
    }
    return resuableView;
}

@end
