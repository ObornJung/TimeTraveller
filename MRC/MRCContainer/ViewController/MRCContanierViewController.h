//
//  MRCContanierViewController.h
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCCell.h"
#import "MRCContainerViewModel.h"
#import "MRCContainerViewModel+Engine.h"
#import "MRCContainerViewModel+Operations.h"

@interface MRCContanierViewController : UIViewController <MRCCellMappingProtocol, MRCCellActionProtocol>

@property (nonatomic, strong) __kindof MRCContainerViewModel  * viewModel;

- (void)setupViews;

- (void)bindViewModel;

- (RACSignal *)reloadData;

- (RACSignal *)loadMoreData;

@end
