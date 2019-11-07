//
//  NSArray+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSArray+KKUtils.h"

@implementation NSArray (KKUtils)

+ (NSArray*)shuffledArrayWithArray:(NSArray*)array {
    NSMutableArray* shuffledArray = [NSMutableArray arrayWithArray:array];
    NSUInteger count = shuffledArray.count;
    if (count < 1) return nil;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return shuffledArray;
}

+ (NSArray *)arrayWithPList:(NSString *)fileName {
    if (!fileName || [fileName isEqualToString:@""])
        return [NSArray new];

    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

- (BOOL)containsExactObject:(id)anObject {
    for (id object in self) {
        if (object == anObject) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)intersectsWithArray:(NSArray *)array {
    NSMutableSet *set1 = [NSMutableSet setWithArray: self];
    NSSet *set2 = [NSSet setWithArray: array];
    [set1 intersectSet: set2];
    return set1.count > 0;
}

- (BOOL)hasZeroElementsOrContainsObject:(id)object{
    return self.count == 0 || [self containsObject:object];
}

@end
