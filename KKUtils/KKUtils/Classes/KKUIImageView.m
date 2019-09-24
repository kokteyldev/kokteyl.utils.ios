//
//  KKUIImageView.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUIImageView.h"

@implementation KKUIImageView

#pragma mark - Setters

- (void)layoutSubviews {
    [super layoutSubviews];
    self.isCircle = _isCircle;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.clipsToBounds = YES;
    [self setNeedsDisplay];
}

- (void)setIsCircle:(BOOL)isCircle {
    _isCircle = isCircle;
    if (isCircle) {
        self.cornerRadius = self.frame.size.width/2.0f;
    } else {
        self.cornerRadius = 0;
    }
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setBorderRatio:(CGFloat)borderRatio {
    self.layer.borderWidth = self.frame.size.width * borderRatio;
    [self setNeedsDisplay];
}

- (void)setIsBlurred:(BOOL)isBlurred{
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    blurEffectView.frame = self.frame;
    [self addSubview:blurEffectView];
}

@end
