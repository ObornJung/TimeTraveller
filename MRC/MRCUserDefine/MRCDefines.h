//
//  MRCDefines.h
//  MRC
//
//  Created by Oborn.Jung on 16/7/21.
//  Copyright © 2016年 wdk. All rights reserved.
//

#ifndef MRC_Defines_h
#define MRC_Defines_h

#import <Availability.h>

#ifdef DEBUG
#define MRCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define MRCLog(fmt, ...)
#endif

#ifdef DEBUG
#define MRCAssert(condition, desc, ...) NSAssert(condition, desc, ##__VA_ARGS__)
#else
#define MRCAssert(...)
#endif

#define MRCSuppressMethodAccessWarning(Stuff) \
do {\
    _Pragma("clang diagnostic push")\
    _Pragma("clang diagnostic ignored\"-Wobjc-method-access\"")\
    Stuff;\
    _Pragma("clang diagnostic pop") \
} while(0)

#ifdef __OBJC__
    #define MAS_SHORTHAND_GLOBALS
    #import <Masonry/Masonry.h>
    #import <libextobjc/EXTScope.h>
#endif

#endif /* MRC_Defines_h */
