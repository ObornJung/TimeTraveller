//
//  MRCCollectionSupplementaryView.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/4.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCModel.h"
#import "MRCCollectionCell.h"

@interface MRCCollectionSupplementaryView : UICollectionReusableView <MRCCollectionCellProtocol>

@property (nonatomic, weak) id<MRCCellActionProtocol>   actionDelegate;

- (void)setupViews;

@end
