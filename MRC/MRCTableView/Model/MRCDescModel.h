//
//  FFMRCDescModel.h
//  FastFood
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCModel.h"

@interface MRCDescModel : MRCModel

@property (nonatomic, copy) NSString    * title;
@property (nonatomic, copy) NSString    * describe;

- (instancetype)initWithTitle:(NSString *)title describe:(NSString *)describe;

@end
