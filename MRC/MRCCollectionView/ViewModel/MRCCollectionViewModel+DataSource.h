//
//  MRCCollectionViewModel+DataSource.h
//  MRC
//
//  Created by Oborn.Jung on 16/6/7.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewModel.h"

@interface MRCCollectionViewModel (DataSource) <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end
