//
//  NSNumber+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSNumber+KKUtils.h"

@implementation NSNumber (KKUtils)

- (NSString *)formatWithThousandsSeperatorWithZero {
    return [self formatWithThousandsSeperatorWithDefaultString:@"0"];
}

- (NSString *)formatWithThousandsSeperatorWithDash {
    return [self formatWithThousandsSeperatorWithDefaultString:@"-"];
}

- (NSString *)formatWithThousandsSeperatorWithDefaultString:(NSString*)defaulString {
    if (self == nil || self.integerValue == 0)
        return defaulString;
    return [self formatWithThousandsSeperator];
}

- (NSString *)formatWithThousandsSeperator {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    return [numberFormatter stringFromNumber: self];
}

- (NSString *)formatWithPercentageSign {
    return [self formatWithPercentageSignAndStringFormatter:@"%@"];
}

- (NSString *)formatWithPercentageSignAndStringFormatter:(NSString*)stringFormatter {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];

    return [NSString stringWithFormat:stringFormatter,
            [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self floatValue]]]];
}

- (NSString *)formatWithOptionalDecimals {

    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:1];
    [numberFormatter setMinimumFractionDigits:0];
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self floatValue]]];
}

- (NSString *)formatWithAbbreviations {

    if ([self longValue]< 1000) {
        return [NSString stringWithFormat:@"%@", self];
    }
    else if ([self longValue]< 1000000)
        return [NSString stringWithFormat:@"%ldK", [self longValue] /1000];
    else
        return [NSString stringWithFormat:@"%ldM", [self longValue] /1000000];
}

- (NSString *)toNSString {
    return [NSString stringWithFormat:@"%@", self];
}

- (NSNumber *)increment {
    return @(self.integerValue + 1);
}
- (NSNumber *)decrement {
    return @(self.integerValue - 1);
}

- (NSNumber *)decrementTillZero {
    if (self.integerValue - 1 < 0) {
        return @0;
    } else {
        return @(self.integerValue - 1);
    }
}

- (NSNumber *)decrementTillOne {
    if (self.integerValue - 1 < 1) {
        return @1;
    } else {
        return @(self.integerValue - 1);
    }
}

- (NSString *)representAsCountDownTimerWithShowingHours:(BOOL)showHours
                                             andMinutes:(BOOL)showMinutes {
    NSUInteger h = self.integerValue / 3600;
    NSUInteger m = (self.integerValue / 60) % 60;
    NSUInteger s = self.integerValue % 60;
    NSString* formatterString = @"";
    if (showHours) {
        formatterString = @"%lu:%02lu:%02lu";
        return [NSString stringWithFormat:formatterString, (unsigned long)h, (unsigned long)m, (unsigned long)s];
    } else if (showMinutes) {
        formatterString = @"%lu:%02lu";
        return [NSString stringWithFormat:formatterString, (unsigned long)m, (unsigned long)s];
    } else {
        formatterString = @"%lu";
        return [NSString stringWithFormat:formatterString, (unsigned long)s];
    }
}

- (NSString *)currencyStringWithCountryCode:(NSString *)code {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:code];
    numberFormatter.usesGroupingSeparator = YES;
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;

    return [numberFormatter stringFromNumber:self];
}

- (NSString *)localizedCurrencyString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.usesGroupingSeparator = NO;

    return [numberFormatter stringFromNumber:self];
}

@end
