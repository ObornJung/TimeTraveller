//
//  MRCSectionModel.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/4.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCSectionModel.h"

@interface MRCSectionModel ()

@property (nonatomic, strong) NSArray       * sectionArray;

@end

@interface MRCMutableSectionModel ()

@property (nonatomic, strong) NSMutableArray    * sectionArray;

@end

@implementation MRCSectionModel

- (instancetype)initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    if (self = [super init]) {
        self.sectionArray = [[NSArray alloc] initWithObjects:objects count:cnt];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self.sectionArray encodeWithCoder:aCoder];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.sectionArray = nil;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    MRCSectionModel * object = [MRCSectionModel allocWithZone:zone];
    object.sectionArray = [self.sectionArray copy];
    object.headerModel = self.headerModel;
    object.footerModel = self.footerModel;
    return object;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    MRCMutableSectionModel * object = [MRCMutableSectionModel allocWithZone:zone];
    object.sectionArray = [self.sectionArray mutableCopy];
    object.headerModel = self.headerModel;
    object.footerModel = self.footerModel;
    return object;
}

- (NSUInteger)count {
    return self.sectionArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < self.sectionArray.count) {
        return self.sectionArray[index];
    }
    return nil;
}

@end

@implementation MRCMutableSectionModel

+ (instancetype)arrayWithCapacity:(NSUInteger)numItems {
    MRCMutableSectionModel * object = [[[self class] alloc] init];
    object.sectionArray = [NSMutableArray arrayWithCapacity:numItems];
    return object;
}

- (nullable NSMutableArray *)initWithContentsOfFile:(NSString *)path {
    if (self = [super init]) {
        self.sectionArray = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return self;
}

- (nullable NSMutableArray *)initWithContentsOfURL:(NSURL *)url {
    if (self = [super init]) {
        self.sectionArray = [NSMutableArray arrayWithContentsOfURL:url];
    }
    return self;
}

- (instancetype)initWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    if (self = [super init]) {
        self.sectionArray = [[NSMutableArray alloc] initWithObjects:objects count:cnt];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sectionArray = [NSMutableArray array];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self.sectionArray encodeWithCoder:aCoder];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.sectionArray = nil;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    MRCSectionModel * object = [MRCSectionModel allocWithZone:zone];
    object.sectionArray = [self.sectionArray copy];
    object.headerModel = self.headerModel;
    object.footerModel = self.footerModel;
    return object;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    MRCMutableSectionModel * object = [MRCMutableSectionModel allocWithZone:zone];
    object.sectionArray = [self.sectionArray mutableCopy];
    object.headerModel = self.headerModel;
    object.footerModel = self.footerModel;
    return object;
}

- (NSUInteger)count {
    return self.sectionArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < self.sectionArray.count) {
        return self.sectionArray[index];
    }
    return nil;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.sectionArray insertObject:anObject atIndex:index];
}

- (void)removeObject:(id)anObject {
    [self.sectionArray removeObject:anObject];
}

- (void)addObject:(id)anObject {
    [self.sectionArray addObject:anObject];
}

- (void)removeLastObject {
    [self.sectionArray removeLastObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.sectionArray replaceObjectAtIndex:index withObject:anObject];
}

@end
