//
//  NSMutableArray+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 7.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSMutableArray+KKUtils.h"

@implementation NSMutableArray (KKUtils)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (BOOL)swapItemAtIndex:(NSInteger)sourceIndex withItemAtIndex:(NSInteger)destinationIndex {

    if (sourceIndex >= self.count || destinationIndex >= self.count || sourceIndex < 0 || destinationIndex < 0) {
        return NO;
    }

    id sourceItem = [self objectAtIndex:sourceIndex];
    id destinationItem = [self objectAtIndex:destinationIndex];

    [self replaceObjectAtIndex:destinationIndex withObject:sourceItem];
    [self replaceObjectAtIndex:sourceIndex withObject:destinationItem];

    return YES;
}

- (BOOL)removeObjectAtIndex:(NSInteger)sourceIndex andInsertAtIndex:(NSInteger)destinationIndex {

    if (sourceIndex >= self.count || destinationIndex >= self.count || sourceIndex < 0 || destinationIndex < 0) {
        return NO;
    }

    id sourceItem = [self objectAtIndex:sourceIndex];
    [self removeObjectAtIndex:sourceIndex];
    [self insertObject:sourceItem atIndex:destinationIndex];

    return YES;

}

@end
