//
//  KKTableViewCell.m
//  KKUtils
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKTableViewCell.h"

@implementation KKTableViewCell {
    CALayer *_topBorderLayer;
    CALayer *_bottomBorderLayer;
}

#pragma mark - Initializer

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _borderPadding = 0;
    _topBorderWidth = 0;
    _bottomBorderWidth = 0;
}

#pragma mark - Setters

- (void)setBorderPadding:(CGFloat)borderPadding {
    _borderPadding = borderPadding;
    [self updateBorder];
}

- (void)setTopBorderWidth:(CGFloat)topBorderWidth {
    _topBorderWidth = topBorderWidth;
    [self updateBorder];
}

- (void)setBottomBorderWidth:(CGFloat)bottomBorderWidth {
    _bottomBorderWidth = bottomBorderWidth;
    [self updateBorder];
}

#pragma mark - Private

- (void)updateBorder {
    if (!_topBorderLayer) {
        _topBorderLayer = [CALayer layer];
        _topBorderLayer.backgroundColor = [UIColor colorNamed:@"border"].CGColor;
        [self.layer addSublayer:_topBorderLayer];
    }

    _topBorderLayer.frame = CGRectMake(_borderPadding, 0.0f, self.frame.size.width - _borderPadding*2, _topBorderWidth);

    if (!_bottomBorderLayer) {
        _bottomBorderLayer = [CALayer layer];
        _bottomBorderLayer.backgroundColor = [UIColor colorNamed:@"border"].CGColor;
        _bottomBorderLayer.name = @"border";
        [self.layer addSublayer:_bottomBorderLayer];
    }

    _bottomBorderLayer.frame = CGRectMake(_borderPadding, self.frame.size.height - _bottomBorderWidth, self.frame.size.width - _borderPadding*2, _bottomBorderWidth);

    self.clipsToBounds = YES;
    [self setNeedsDisplay];
}
@end
