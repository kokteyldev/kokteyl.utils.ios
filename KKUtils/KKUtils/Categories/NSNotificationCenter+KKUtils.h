//
//  NSNotificationCenter+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 8.11.2021.
//  Copyright © 2021 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (KKUtils)
- (void)addObserver:(id)observer selector:(SEL)aSelector names:(NSArray<NSNotificationName> *)names object:(nullable id)anObject;
- (void)removeObserver:(id)observer names:(NSArray<NSNotificationName> *)names object:(nullable id)anObject;
@end

NS_ASSUME_NONNULL_END
