//
//  NSObject+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KKUtils)

- (void)bindValuesOfObject:(NSObject *)object;
- (void)addHeaders:(NSDictionary *)headers;
@end

