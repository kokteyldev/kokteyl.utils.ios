//
//  KKUIButton.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUIButton.h"
#import "KKMacros.h"

@implementation KKUIButton {
    UIImageView* _VIconImage;
}

#pragma mark - Initializer

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    [self commonInit];
    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    if (!(self = [super initWithCoder:coder]))
        return nil;
    [self commonInit];
    return self;
}

- (void)commonInit {
    self.iconImageLeftPadding =
    self.iconImageRightPadding =
    self.iconImageTopPadding =
    CGFLOAT_MAX;

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)layoutSubviews {
    if (_iconImage != nil || [_iconImage isEqualToString:@""]) {
        self.iconImage = _iconImage;
    }
    [super layoutSubviews];
}

#pragma mark - Setters

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
        self.clipsToBounds = YES;
        [self setNeedsDisplay];
    }
}

- (void)setLocalizedKey:(NSString *)localizedKey {
    _localizedKey = localizedKey;
    NSString* localizedString = [getBundle localizedStringForKey:(_localizedKey) value:@"" table:nil];
    [self setTitle:localizedString forState:UIControlStateNormal];
    [self setTitle:localizedString forState:UIControlStateSelected];
    [self setTitle:localizedString forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setIconImage:(NSString *)iconImage {
    _iconImage = iconImage;
    [_VIconImage removeFromSuperview];
    UIImage* image = [UIImage imageNamed:iconImage inBundle:nil compatibleWithTraitCollection:nil];
    CGFloat x = 0;
    if (self.iconImageLeftPadding == CGFLOAT_MAX && self.iconImageRightPadding == CGFLOAT_MAX) {
        x = 0;
    } else  if (self.iconImageLeftPadding == CGFLOAT_MAX && self.iconImageRightPadding != CGFLOAT_MAX) {
        x = self.frame.size.width - image.size.width - self.iconImageRightPadding;
    } else if (self.iconImageLeftPadding != CGFLOAT_MAX && self.iconImageRightPadding == CGFLOAT_MAX) {
        x = self.iconImageLeftPadding;
    }
    CGFloat y = -2 + (self.frame.size.height - image.size.height)/2;
    if (self.iconImageTopPadding != CGFLOAT_MAX) {
        y = self.iconImageTopPadding;
    }
    _VIconImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, image.size.width, image.size.height)];
    _VIconImage.image = [UIImage imageNamed:iconImage inBundle:nil compatibleWithTraitCollection:nil];
    [self addSubview:_VIconImage];
    [self setNeedsDisplay];
}

- (void)setIconImageLeftPadding:(CGFloat)iconImageLeftPadding {
    _iconImageLeftPadding = iconImageLeftPadding;
    if (self.iconImage != nil) {
        [_VIconImage removeFromSuperview];
        self.iconImage = _iconImage;
        [self setNeedsDisplay];
    }
}

- (void)setIconImageRightPadding:(CGFloat)iconImageRightPadding {
    _iconImageRightPadding = iconImageRightPadding;
    if (self.iconImage != nil) {
        [_VIconImage removeFromSuperview];
        self.iconImage = _iconImage;
        [self setNeedsDisplay];
    }
}

- (void)setIconImageTopPadding:(CGFloat)iconImageTopPadding {
    _iconImageTopPadding = iconImageTopPadding;
    if (self.iconImage != nil) {
        [_VIconImage removeFromSuperview];
        self.iconImage = _iconImage;
        [self setNeedsDisplay];
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

@end
