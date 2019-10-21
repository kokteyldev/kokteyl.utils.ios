//
//  NSString+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSString+KKUtils.h"
#import "NSData+KKUtils.h"

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

- (NSString *)encryptWithKey:(NSString *)key {
    if (!self || self.length == 0 ||
        !key || key.length == 0) {
        return nil;
    }
    
    //Generate random init vector for encryption
    NSString *iv = [NSString generateIV];
    
    //Encrypt with key and iv
    NSData *encryptedData;
    
    if (key.length == 32) {
        encryptedData = [[self dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataWithKey:key iv:iv];
    } else {
        encryptedData = [[self dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptedDataWithKey:key iv:iv];
    }
    
    //Convert data to hex
    NSString *encryptedHex = [encryptedData hexadecimalString];
    
    //Convert iv to hex
    NSString *ivHex = [[iv dataUsingEncoding:NSUTF8StringEncoding] hexadecimalString];
    
    return [NSString stringWithFormat:@"%@%@", ivHex, encryptedHex];
}

#pragma mark - Util

+ (NSString *)generateIV {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789/=+";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:16];
    
    for (int i=0; i<16; i++) {
        [randomString appendFormat: @"%C", [alphabet characterAtIndex: arc4random_uniform((int)[alphabet length])]];
    }
    
    NSString *iv = randomString;
    
    return iv;
}

@end
