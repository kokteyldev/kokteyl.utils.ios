//
//  KKUIView.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUIView.h"
#import "KKMacros.h"

@implementation KKUIView

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
    ;;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.isCircle = _isCircle;
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

- (void)setBackgroundTileImageName:(NSString *)backgroundTileImageName{
    _backgroundTileImageName = backgroundTileImageName;
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:_backgroundTileImageName
                                                                       inBundle:getBundle
                                                  compatibleWithTraitCollection:nil]]];
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
