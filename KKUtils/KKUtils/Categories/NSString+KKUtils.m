//
//  NSString+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSString+KKUtils.h"

@implementation NSString (KKUtils)

- (NSString *)trimSpaces {
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSDate *)shortDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];

    return [dateFormatter dateFromString:self];
}

- (BOOL)isValidPhoneNumber {
    if (self == nil || self.length == 0) return NO;

    NSString *regexPattern = @"5[(0-9)]{9}";
    NSPredicate *PNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];

    BOOL matches = [PNTest evaluateWithObject:self];

    return matches;
}

- (BOOL)isValidPhoneNumberForRegexPattern:(NSString *)regexPattern {
    if (self == nil || self.length == 0) return NO;

    NSPredicate *PNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];

    BOOL matches = [PNTest evaluateWithObject:self];

    return matches;
}

- (BOOL)isValidPlateNumber {
    if (self == nil || self.length == 0) return NO;

    NSString *regexPattern = @"[(0-9)]{2}[a-zA-Z]{1,3}[(0-9)]{2,4}";
    NSPredicate *PNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];

    BOOL matches = [PNTest evaluateWithObject:self];

    return matches;
}

- (BOOL)isValidTcId {
    if (self == nil || self.length == 0) return NO;

    NSString *regexPattern = @"[1-9]{1}[0-9]{10}";
    NSPredicate *PNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];

    BOOL matches = [PNTest evaluateWithObject:self];

    return matches;
}

- (BOOL)isValidName {
    if (self == nil || self.length == 0) return NO;

    if (self.length > 2 && self.length < 50)
        return YES;

    return NO;
}

- (BOOL)isValidEmail {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (trimmedString == nil || trimmedString.length == 0) return NO;

    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:trimmedString];
}

- (BOOL)isValidAccessToken {
    if (self == nil || self.length == 0) return NO;

    return YES;
}

- (BOOL)isValidShortDate {
    if (self == nil || self.length == 0) return NO;

    NSDate *date = [self shortDate];

    return date != nil;
}

@end
