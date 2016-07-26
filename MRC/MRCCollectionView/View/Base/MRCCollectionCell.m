//
//  MRCCollectionCell.m
//  MRC
//
//  Created by Oborn.Jung on 16/3/28.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionCell.h"

@implementation MRCCollectionCell

+ (NSString *)mrc_reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)layout
            sizeForModel:(MRCModel *)model {
    return CGSizeZero;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.clipsToBounds               = YES;
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

@end
