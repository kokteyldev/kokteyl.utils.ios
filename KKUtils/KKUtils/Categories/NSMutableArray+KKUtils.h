//
//  NSMutableArray+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 7.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (KKUtils)
- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)swapItemAtIndex:(NSInteger)sourceIndex withItemAtIndex:(NSInteger)destinationIndex;
- (BOOL)removeObjectAtIndex:(NSInteger)sourceIndex andInsertAtIndex:(NSInteger)destinationIndex;
@end


