//
//  NSNotificationCenter+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 8.11.2021.
//  Copyright © 2021 Tolga Seremet. All rights reserved.
//

#import "NSNotificationCenter+KKUtils.h"

@implementation NSNotificationCenter (KKUtils)

- (void)addObserver:(id)observer selector:(SEL)aSelector names:(NSArray<NSNotificationName> *)names object:(nullable id)anObject {
    for (NSNotificationName name in names) {
        [self addObserver:observer selector:aSelector name:name object:anObject];
    }
}

- (void)removeObserver:(id)observer names:(NSArray<NSNotificationName> *)names object:(nullable id)anObject {
    for (NSNotificationName name in names) {
        [self removeObserver:observer name:name object:anObject];
    }
}

@end
