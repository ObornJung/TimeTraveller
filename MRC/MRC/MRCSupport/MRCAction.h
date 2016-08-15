//
//  MRCAction.h
//  MRC
//
//  Created by Oborn.Jung on 16/6/17.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MRCActionType) {
    MRCActionTypeReload,
    MRCActionTypeInsert,
    MRCActionTypeDelete,
    MRCActionTypeMove,
    MRCActionTypeCustom,
};

typedef NS_ENUM(NSUInteger, MRCActionSubType) {
    MRCActionSubTypeAll,
    MRCActionSubTypeItems,
    MRCActionSubTypeSections,
};

@interface MRCAction : NSObject

@property (nonatomic, assign, readonly) MRCActionType           type;
@property (nonatomic, assign, readonly) MRCActionSubType        subType;
@property (nonatomic, strong, readonly) NSArray<NSIndexPath *>  * items;
@property (nonatomic, strong, readonly) NSIndexSet              * sections;

@property (nonatomic, assign) BOOL  animated;           ///< animated of update,default:YES
@property (nonatomic, strong) id    context;            ///< context
@property (nonatomic, copy) void (^completion)(BOOL);   ///< completion of action

+ (instancetype)actionOfLoadMore;
+ (instancetype)actionOfReloadAll;
+ (instancetype)actionOfReloadSections:(NSIndexSet *)sections;
+ (instancetype)actionOfReloadItems:(NSArray<NSIndexPath *> *)items;

+ (instancetype)actionOfInserSections:(NSIndexSet *)sections;
+ (instancetype)actionOfInsertItems:(NSArray<NSIndexPath *> *)items;

+ (instancetype)actionOfDeleteSections:(NSIndexSet *)sections;
+ (instancetype)actionOfDeleteItems:(NSArray<NSIndexPath *> *)items;
/**
 *    context = @{@"from":@(section),@"to":@(newSection)};
 */
+ (instancetype)actionOfMoveSection:(NSInteger)section
                          toSection:(NSInteger)newSection;
/**
 *    context = @{@"from":indexPath,@"to":newIndexPath}
 */
+ (instancetype)actionOfMoveItemFrom:(NSIndexPath *)items
                                  to:(NSIndexPath *)newIndexPath;

- (instancetype)initWithType:(MRCActionType)type
                     subType:(MRCActionSubType)subType;

@end
