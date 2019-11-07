//
//  NSArray+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KKUtils)

+ (NSArray *)shuffledArrayWithArray:(NSArray *)array;
+ (NSArray *)arrayWithPList:(NSString *)fileName;
- (BOOL)containsExactObject:(id)anObject;
- (BOOL)intersectsWithArray:(NSArray *)array;
- (BOOL)hasZeroElementsOrContainsObject:(id)object;

@end

