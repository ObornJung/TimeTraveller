//
//  MRCSectionModel.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/4.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCModel.h"
#import <Foundation/Foundation.h>

@interface MRCSectionModel : NSArray

@property (nonatomic, strong) MRCModel    * headerModel;
@property (nonatomic, strong) MRCModel    * footerModel;

@end

@interface MRCMutableSectionModel : NSMutableArray

@property (nonatomic, strong) MRCModel    * headerModel;
@property (nonatomic, strong) MRCModel    * footerModel;

@end
