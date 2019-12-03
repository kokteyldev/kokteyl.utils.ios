//
//  NSDate+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 25.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSDate+KKUtils.h"

@implementation NSDate (KKUtils)

- (NSString *)shortDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM YYYY"];

    return [formatter stringFromDate:self];
}

- (NSDate *)startOfWeek {
    NSDate *startOfWeek;
    NSTimeInterval interval;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfYear
                                    startDate:&startOfWeek
                                     interval:&interval
                                      forDate:self];
    return startOfWeek;
}

- (NSDate *)endOfWeek {
    NSDate *startOfWeek;
    NSTimeInterval interval;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfYear
                                    startDate:&startOfWeek
                                     interval:&interval
                                      forDate:self];
    return [startOfWeek dateByAddingTimeInterval:interval - 1];
}


@end
