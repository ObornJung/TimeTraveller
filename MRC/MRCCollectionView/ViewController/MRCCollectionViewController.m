//
//  MRCCollectionViewController.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "MRCCollectionViewController.h"
#import "MRCCollectionViewModel+DataSource.h"

@interface MRCCollectionViewController ()

@property (nonatomic, strong) UICollectionView          * collectionView;
@property (nonatomic, strong) UICollectionViewLayout    * collectionViewLayout;

@end


@implementation MRCCollectionViewController
@dynamic viewModel;

- (void)setViewModel:(__kindof MRCCollectionViewModel *)viewModel {
    viewModel.cellFactory = self;
    viewModel.cellActionDelegate = self;
    self.collectionView.dataSource = viewModel;
    [super setViewModel:viewModel];
}

- (void)setupViews {
    [super setupViews];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    /**
     *    setup list view
     */
    [self.view addSubview:({
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        _collectionView.delaysContentTouches = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView;
    })];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    MRCCollectionViewModel * viewModel = self.viewModel;
    viewModel.cellFactory = self;
    viewModel.cellActionDelegate = self;
    _collectionView.dataSource = viewModel;
}

- (void)bindViewModel {
    RAC(self, title) = [RACObserve(self.viewModel, title) distinctUntilChanged];
    [super bindViewModel];
}

- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewLayout * layout = self.collectionView.collectionViewLayout;
    if (!layout) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.headerReferenceSize = CGSizeZero;
        flowLayout.footerReferenceSize = CGSizeZero;
        layout = flowLayout;
    }
    return layout;
}

#pragma mark - FFContainerCellMappingProtocol

- (nullable Class)cellClassForModel:(nonnull MRCModel *)model {
    return nil;
}

@end
