//
//  NSString+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (KKUtils)

- (NSString *)trimSpaces;
- (NSDate *)shortDate;

- (UIImage *)qrCodeImage;
- (NSString *)currencySymbol;
- (NSNumber *)localizedNumber;

- (NSString *)convertNeedleToRegexPattern;

- (BOOL)isValidPhoneNumber;
- (BOOL)isValidPhoneNumberForRegexPattern:(NSString *)regexPattern;
- (BOOL)isValidPlateNumber;
- (BOOL)isValidTcId;
- (BOOL)isValidName;
- (BOOL)isValidEmail;
- (BOOL)isValidAccessToken;
- (BOOL)isValidShortDate;



@end

