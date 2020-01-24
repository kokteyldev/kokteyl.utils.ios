//
//  NSNumber+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (KKUtils)

- (NSString *)formatWithThousandsSeperatorWithZero;
- (NSString *)formatWithThousandsSeperatorWithDash;
- (NSString *)formatWithThousandsSeperatorWithDefaultString:(NSString *)defaulString;
- (NSString *)formatWithThousandsSeperator;
- (NSString *)formatWithPercentageSign;
- (NSString *)formatWithPercentageSignAndStringFormatter:(NSString *)stringFormatter;
- (NSString *)formatWithOptionalDecimals;
- (NSString *)formatWithAbbreviations;
- (NSString *)toNSString;
- (NSNumber *)increment;
- (NSNumber *)decrement;
- (NSNumber *)decrementTillZero;
- (NSNumber *)decrementTillOne;
- (NSString *)representAsCountDownTimerWithShowingHours:(BOOL)showHours
                                             andMinutes:(BOOL)showMinutes;
- (NSString *)currencyStringWithCountryCode:(NSString *)code;
- (NSString *)localizedCurrencyString;

@end

