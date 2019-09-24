//
//  UIScreen+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIScreen+KKUtils.h"

@implementation UIScreen (KKUtils)

+ (CGFloat)width {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)height {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)isIphoneXFamily {
    CGFloat height = [UIScreen mainScreen].nativeBounds.size.height;
    return
    height == 2436 ||
    height == 2688 ||
    height == 1792 ;
}

@end
