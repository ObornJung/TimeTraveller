//
//  MRCCollectionViewModel.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCContainerViewModel.h"

@interface MRCCollectionViewModel : MRCContainerViewModel

@property (nonatomic, strong, nullable) NSString                    * title;

- (void)implementMethod:(nonnull SEL)selector withBlock:(nullable id)block;

- (nullable id)blockImplementationForMethod:(nonnull SEL)selector;

@end
