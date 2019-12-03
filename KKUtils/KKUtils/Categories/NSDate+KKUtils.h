
//
//  NSDate+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 25.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KKUtils)

- (NSString *)shortDateString;
- (NSDate *)startOfWeek;
- (NSDate *)endOfWeek;

@end
