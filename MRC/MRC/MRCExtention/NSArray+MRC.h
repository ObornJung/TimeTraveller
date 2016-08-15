//
//  NSArray+MRC.h
//  MRC
//
//  Created by Oborn.Jung on 12/2/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MRC)

- (NSArray *)mrc_deepCopy;

- (NSMutableArray *)mrc_mutableDeepCopy;

@end
