//
//  KKCircularBar.m
//  KKUtilsDemo
//
//  Created by Mehmet Karagöz on 17.02.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "KKCircularBar.h"

@implementation KKCircularBar {
    CGFloat _currentAngle;
    CGFloat _angleIncrement;
    NSInteger _countDownValue;
    NSTimer *_animationTimer;
    UILabel *_countDownLabel;
    UIButton *_closeButton;
    BOOL _started;
}

#pragma mark - View lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Public initializer

+ (instancetype)barWithFrame:(CGRect)frame
                       color:(UIColor *)color
                    duration:(NSInteger)duration
                        font:(UIFont *)font {
    return [[[self class] alloc] initWithFrame:frame
                                          font:font
                                         color:color
                                      duration:duration];
}

- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)font
                        color:(UIColor *)color
                     duration:(NSInteger)duration {

    if (!(self = [super initWithFrame:frame]))
        return nil;

    _font = font;
    _color = color;
    _duration = duration;

    [self commonInit];
    
    return self;
}

#pragma mark - Public

- (void)start {
    if ((_started)) return;
    
    _started = YES;
    self.hidden = NO;
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.duration/360.0
                                                       target:self
                                                     selector:@selector(tickTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    [_animationTimer fire];
}

- (void)stop {
    _started = NO;
    self.hidden = YES;
}

- (void)restart {
    _started = NO;
    self.hidden = NO;
    _currentAngle = 0;
    _countDownValue = _duration;
    [self start];
}

#pragma mark - Private

- (void)commonInit {
    if (self.font == nil) {
        self.font = [UIFont systemFontOfSize:14.0];
    }
    
    if (self.color == nil) {
        self.color = [UIColor blackColor];
    }
    
    if (self.duration == 0) {
        self.duration = 10;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.alpha = CGColorGetAlpha(self.color.CGColor);
    self.strokeWidth = 3.0;
    
    _currentAngle = 0;
    _countDownValue = self.duration;
    _angleIncrement = 360.0/(float)self.duration;

    _started = NO;

    [self createLabel];
}

#pragma mark - Visual

- (void)createLabel {
    CGFloat labelWidth = self.frame.size.width;

    _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 - labelWidth/2,
                                                                self.frame.size.height/2.0 - labelWidth/2,
                                                                labelWidth,
                                                                labelWidth)];
    _countDownLabel.text = [NSString stringWithFormat:@"%ld", (long)_countDownValue];
    _countDownLabel.font = _font;
    _countDownLabel.textAlignment = NSTextAlignmentCenter;
    _countDownLabel.textColor = _color;
    [self addSubview:_countDownLabel];
}

- (void)createButton {
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _closeButton.backgroundColor = [UIColor clearColor];
    [_closeButton addTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeButton];
}

- (void)drawCross {
    CGFloat padding = 17;
    CGFloat startPoint = padding;
    CGFloat endPoint = self.frame.size.width - padding;

    UIBezierPath* path1 = [UIBezierPath bezierPath];
    UIBezierPath* path2 = [UIBezierPath bezierPath];

    path1.lineCapStyle = path2.lineCapStyle = kCGLineCapRound;
    [path1 moveToPoint: CGPointMake(startPoint, endPoint)];
    [path1 addLineToPoint: CGPointMake(endPoint, startPoint)];
    [_color setStroke];
    path1.lineWidth = self.strokeWidth;
    [path1 stroke];
    [path2 moveToPoint: CGPointMake(startPoint, startPoint)];
    [path2 addLineToPoint: CGPointMake(endPoint, endPoint)];
    [_color setStroke];
    path2.lineWidth = self.strokeWidth;
    [path2 stroke];
}

#pragma mark - IBActions

- (IBAction)didTap {
    [_closeButton removeTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
    if ([_delegate respondsToSelector:@selector(circularBarDidTap:)]) {
        [_delegate circularBarDidTap:self];
    }
}

#pragma mark - Timer

- (void)tickTimer {
    if (_currentAngle == 360) {
        [_animationTimer invalidate];
        _animationTimer = nil;
        [self createButton];
        [self setNeedsDisplay];

        return;
    }
    
    _currentAngle ++;
    _countDownValue = _duration - floor(_currentAngle/_angleIncrement);
    
    if (_countDownValue == 0) {
        _countDownLabel.text = @"";
    } else {
        if (![_countDownLabel.text isEqualToString:[NSString stringWithFormat:@"%ld", (long)_countDownValue]]) {
            [UIView transitionWithView:_countDownLabel
                              duration:.4f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                self->_countDownLabel.text = [NSString stringWithFormat:@"%ld", (long)self->_countDownValue];
            } completion:nil];
        }
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if  (!_animationTimer || !_animationTimer.isValid) {
        if ([_delegate respondsToSelector:@selector(circularBarDidFinish:)])
            [_delegate circularBarDidFinish:self];
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, rect.size.width/2.0 , rect.size.height/2.0, (rect.size.width-self.strokeWidth-5)/2, [KKCircularBar radiansForDegrees:-90], [KKCircularBar radiansForDegrees:-90 + _currentAngle], 0);
    CGContextSetStrokeColorWithColor(context, [_color CGColor]);
    CGContextSetLineWidth(context, self.strokeWidth);
    CGContextStrokePath(context);
}

#pragma mark - Utilities

+ (float)radiansForDegrees:(double)degrees {
    return degrees * M_PI / 180;
}

@end
