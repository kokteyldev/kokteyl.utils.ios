//
//  UIColor+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
} rgbColor;

@interface UIColor (KKUtils)

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (rgbColor)rgbColor;
- (NSString *)hexString;

@end



