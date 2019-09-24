//
//  UIColor+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIColor+KKUtils.h"

@implementation UIColor (KKUtils)

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString andAlpha:1];
}

- (rgbColor)rgbColor {
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    rgbColor rgb;
    rgb.red = red;
    rgb.green = green;
    rgb.blue = blue;
    return rgb;
}

- (NSString *)hexString {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    size_t count = CGColorGetNumberOfComponents(self.CGColor);

    if(count == 2) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                lroundf(components[0] * 255.0),
                lroundf(components[0] * 255.0),
                lroundf(components[0] * 255.0)];
    } else {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                lroundf(components[0] * 255.0),
                lroundf(components[1] * 255.0),
                lroundf(components[2] * 255.0)];
    }
}

@end
