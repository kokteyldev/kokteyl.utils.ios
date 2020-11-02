//
//  KKPaginatedList.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKPaginatedList.h"
#import <UIKit/UIkit.h>

@implementation KKPaginatedList {
    NSMutableArray *_items;
}

+ (instancetype)paginatedListWithPageSize:(NSInteger)pageSize {
    return [[self alloc]initWithItems:nil pageSize:pageSize];
}

+ (instancetype)paginatedListWithItems:(NSArray *)items pageSize:(NSInteger)pageSize {
    return [[self alloc]initWithItems:items pageSize:pageSize];
}

- (instancetype)initWithItems:(NSArray *)items pageSize:(NSInteger)pageSize {
    if (!(self = [super init])) return nil;
    _pageSize = pageSize;
    _pageIndex = 0;
    [self addItems:items];
    return self;
}

- (instancetype)init {
    if (!(self = [super init])) return nil;
    return self;
}

#pragma mark - Getters

- (NSArray *)items {
    return [NSArray arrayWithArray:_items];
}

#pragma mark - Accessors

- (NSArray *)addItems:(NSArray *)items {
    if (_items == nil) _items = [NSMutableArray new];
    [_items addObjectsFromArray:items];
    _isNextPageAvailable = items.count == _pageSize;
    return [NSArray arrayWithArray:_items];
}

- (NSArray *)addUniqueItems:(NSArray *)items {
    if (_items == nil) _items = [NSMutableArray new];
    for (id object in items) {
        if (![_items containsObject:object]) {
            [_items addObject:object];
        }
    }
    _isNextPageAvailable = items.count == _pageSize;
    return [NSArray arrayWithArray:_items];
}

- (NSArray *)addItems:(NSArray *)items withItemCount:(NSInteger)itemsCount {
    if (_items == nil) _items = [NSMutableArray new];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,[items count])];
    [_items insertObjects:items atIndexes:indexes];

    _isNextPageAvailable = itemsCount == _pageSize;
    return [NSArray arrayWithArray:_items];
}

- (NSArray *)addExtraItems:(NSArray *)items {
    if (_items == nil) _items = [NSMutableArray new];
    [_items addObjectsFromArray:items];
    return [NSArray arrayWithArray:_items];
}

- (NSArray *)replaceObjectAtIndex:(NSUInteger)idx withObject:(NSObject *)object {
    [_items replaceObjectAtIndex:idx withObject:object];
    return [NSArray arrayWithArray:_items];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_items == nil) return;
    [_items removeObjectAtIndex:indexPath.row];
}

- (void)removeItem:(id)item {
    if (_items == nil) return;
    [_items removeObject:item];
}

- (void)resetItems {
    _pageIndex = 0;
    [_items removeAllObjects];
    _isNextPageAvailable = NO;
}

@end
