//
//  MRCCollectionCell.h
//  MRC
//
//  Created by Oborn.Jung on 16/3/28.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCell.h"

@class MRCCollectionCell;

@protocol MRCCollectionCellProtocol <MRCReusableViewProtocol>
@optional

+ (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)layout
            sizeForModel:(MRCModel *)model;

@end

@interface MRCCollectionCell : UICollectionViewCell<MRCCollectionCellProtocol>

@property (nonatomic, weak) id<MRCCellActionProtocol>   actionDelegate;

- (void)setupViews;

@end
