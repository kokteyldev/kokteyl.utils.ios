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

@end
