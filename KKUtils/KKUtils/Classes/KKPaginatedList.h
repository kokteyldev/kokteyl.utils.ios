//
//  KKPaginatedList.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKPaginatedList : NSObject

@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, assign, readonly) BOOL isNextPageAvailable;
@property (nonatomic, assign, readonly) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageIndex;

+ (instancetype)paginatedListWithPageSize:(NSInteger)pageSize;
+ (instancetype)paginatedListWithItems:(NSArray *)items pageSize:(NSInteger)pageSize;
- (NSArray *)addItems:(NSArray *)items;
- (NSArray *)addItems:(NSArray *)items withItemCount:(NSInteger)itemsCount;
- (NSArray *)addExtraItems:(NSArray *)items;
- (void)removeItemAtIndexPath:(NSIndexPath*)indexPath;
- (void)removeItem:(id)item;
- (void)resetItems;

@end

