//
//  MRCModel.h
//  MRC
//
//  Created by Oborn.Jung on 16/3/25.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, MRCModelStatus) {
    MRCModelStatusNormal    = 0,
    MRCModelStatusDisable   = 1,
    MRCModelStatusHidden    = 2
};

@class MRCModel;

@interface MRCModelValidity : NSObject

@property (nonatomic, assign  ) BOOL                valid;
@property (nonatomic, nullable) NSString            * errorMsg;
@property (nonatomic, weak, nullable) MRCModel      * associationModel;

@end

@interface MRCModel : NSObject

@property (nonatomic, nonnull, strong) NSString             * tag;
@property (nonatomic, nonnull, strong) NSString             * identifier;
@property (nonatomic, nullable, readonly) MRCModelValidity  * validate;
@property (nonatomic, strong, nullable  ) id                object;
@property (nonatomic, assign) MRCModelStatus                modelStatus;

//- (id)initWithData:(NSDictionary *)data;
//
//- (void)reload:(NSDictionary *)data;

@end
