//
//  MRCCollectionViewController.h
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCollectionViewModel.h"
#import "MRCContanierViewController.h"

@interface MRCCollectionViewController : MRCContanierViewController

@property (nonatomic, strong) __kindof MRCCollectionViewModel   * viewModel;
@property (nonatomic, strong, readonly) UICollectionView        * collectionView;
@property (nonatomic, strong, readonly) UICollectionViewLayout  * collectionViewLayout;

@end
