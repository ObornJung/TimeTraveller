//
//  MRCAction.m
//  MRC
//
//  Created by Oborn.Jung on 16/6/17.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCAction.h"
#import "MRCAction+Private.h"

@interface MRCAction ()

@property (nonatomic, assign) MRCActionType             type;
@property (nonatomic, assign) MRCActionSubType          subType;
@property (nonatomic, strong) NSArray<NSIndexPath *>    * items;
@property (nonatomic, strong) NSIndexSet                * sections;

@end

@implementation MRCAction

+ (instancetype)actionOfLoadMore {
    return [self actionOfReloadAll];
}

+ (instancetype)actionOfReloadAll {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeReload
                                            subType:MRCActionSubTypeAll];
    return action;
}

+ (instancetype)actionOfReloadSections:(NSIndexSet *)sections {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeReload
                                            subType:MRCActionSubTypeSections];
    action.sections = sections;
    return action;
}

+ (instancetype)actionOfReloadItems:(NSArray<NSIndexPath *> *)items {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeReload
                                            subType:MRCActionSubTypeItems];
    action.items = items;
    return action;
}

+ (instancetype)actionOfInserSections:(NSIndexSet *)sections {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeInsert
                                            subType:MRCActionSubTypeSections];
    action.sections = sections;
    return action;
}

+ (instancetype)actionOfInsertItems:(NSArray<NSIndexPath *> *)items {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeInsert
                                            subType:MRCActionSubTypeItems];
    action.items = items;
    return action;
}

+ (instancetype)actionOfDeleteSections:(NSIndexSet *)sections {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeDelete
                                            subType:MRCActionSubTypeSections];
    action.sections = sections;
    return action;
}

+ (instancetype)actionOfDeleteItems:(NSArray<NSIndexPath *> *)items {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeDelete
                                            subType:MRCActionSubTypeItems];
    action.items = items;
    return action;
}

+ (instancetype)actionOfMoveSection:(NSInteger)section toSection:(NSInteger)newSection {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeMove
                                            subType:MRCActionSubTypeSections];
    action.context = @{@"from":@(section),@"to":@(newSection)};
    return action;
}

+ (instancetype)actionOfMoveItemFrom:(NSIndexPath *)indexPath to:(NSIndexPath *)newIndexPath {
    MRCAction * action = [[self alloc] initWithType:MRCActionTypeMove
                                              subType:MRCActionSubTypeItems];
    action.context = @{@"from":indexPath,@"to":newIndexPath};
    return action;
}

- (instancetype)init {
    return [self initWithType:MRCActionTypeReload subType:MRCActionSubTypeAll];
}

- (instancetype)initWithType:(MRCActionType)type subType:(MRCActionSubType)subType {
    self = [super init];
    if (self) {
        _type = type;
        _subType = subType;
        [self setupWithTemplete:[[self class] actionTemplete]];
    }
    return self;
}

- (void)setupWithTemplete:(MRCAction *)action {
    if (action) {
        _animated = action.animated;
        _completion = [action.completion copy];
    } else {
        _animated = YES;
        _completion = nil;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"type:%ld\nsubtype:%ld\nanimated:%d\ncontext:%@", (long)self.type, (long)self.subType, self.animated, self.context];
}

@end

