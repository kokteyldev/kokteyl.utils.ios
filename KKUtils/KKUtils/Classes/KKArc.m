//
//  KKArc.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKArc.h"
#import "UIColor+KKUtils.h"

NSString *const kKKArcLocationKey = @"KKArcLocation";
NSString *const kKKArcColorKey = @"KKArcColor";
NSString *const kKKArcAlphaKey = @"KKArcAlpha";
NSString *const kKKArcDurationKey = @"KKArcDuration";

CGSize const kKKArcFrameSize = {50, 50};
CGFloat const kKKArcPadding = 0;
CGFloat const kKKArcStrokeWidth = 3;

@implementation KKArc {
    UIColor *_color;
    CGFloat _currentAngle;
    CGFloat _angleIncrement;
    NSInteger _duration;
    NSInteger _countDownValue;
    NSTimer *_animationTimer;
    UILabel *_countDownLabel;
    UIButton *_closeButton;
    __weak id<KKArcDelegate> _delegate;
    BOOL _started;
}

#pragma mark - NSObject

+ (instancetype)arcWithDictionary:(NSDictionary *)options
                         delegate:(id<KKArcDelegate>)delegate {


    NSMutableDictionary *optionsDict = [NSMutableDictionary dictionaryWithDictionary:
                                        @{
                                            kKKArcLocationKey:@0,
                                            kKKArcColorKey:@"#FFFFFF",
                                            kKKArcAlphaKey:@.75,
                                            kKKArcDurationKey:@3
                                        }
                                        ];

    if ([options objectForKey:kKKArcLocationKey] &&
        [[options objectForKey:kKKArcLocationKey] isKindOfClass:[NSNumber class]]) {
        [optionsDict setObject:[options objectForKey:kKKArcLocationKey] forKey:kKKArcLocationKey];
    }

    if ([options objectForKey:kKKArcColorKey] &&
        [[options objectForKey:kKKArcColorKey] isKindOfClass:[NSString class]] &&
        [((NSString *)[options objectForKey:kKKArcColorKey]) length] == 7 ) {
        [optionsDict setObject:[options objectForKey:kKKArcColorKey] forKey:kKKArcColorKey];
    }

    if ([options objectForKey:kKKArcAlphaKey] &&
        [[options objectForKey:kKKArcAlphaKey] isKindOfClass:[NSNumber class]]) {
        [optionsDict setObject:[options objectForKey:kKKArcAlphaKey] forKey:kKKArcAlphaKey];
    }

    if ([options objectForKey:kKKArcDurationKey] &&
        [[options objectForKey:kKKArcDurationKey] isKindOfClass:[NSNumber class]]) {
        [optionsDict setObject:[options objectForKey:kKKArcDurationKey] forKey:kKKArcDurationKey];
    }

    return [KKArc arcWithLocation:[[optionsDict objectForKey:kKKArcLocationKey] integerValue]
                            color:[UIColor colorWithHexString:[optionsDict objectForKey:kKKArcColorKey]
                                                     andAlpha:[[optionsDict objectForKey:kKKArcAlphaKey] floatValue]]
                         duration:[[optionsDict objectForKey:kKKArcDurationKey] integerValue]
                         delegate:delegate];

}


+ (instancetype)arcWithLocation:(KKArcLocation)location
                          color:(UIColor *)color
                       duration:(NSInteger)duration
                       delegate:(id<KKArcDelegate>)delegate {

    return [[[self class] alloc] initWithLocation:location
                                            color:color
                                         duration:duration
                                         delegate:delegate];
}

- (instancetype)initWithLocation:(KKArcLocation)location
                           color:(UIColor *)color
                        duration:(NSInteger)duration
                        delegate:(id<KKArcDelegate>)delegate {
    CGRect frame;

    if (location == KKArcLocationLeft) {
        frame = CGRectMake(kKKArcPadding, kKKArcPadding*2, kKKArcFrameSize.width, kKKArcFrameSize.height);
    } else {
        frame = CGRectMake([UIScreen mainScreen].bounds.size.width - kKKArcPadding - kKKArcFrameSize.width, kKKArcPadding*2, kKKArcFrameSize.width, kKKArcFrameSize.height);
    }

    if (!(self = [super initWithFrame:frame]))
        return nil;

    self.backgroundColor = [UIColor clearColor];

    const CGFloat* components = CGColorGetComponents(color.CGColor);
    _color = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:1];
    self.alpha = CGColorGetAlpha(color.CGColor);

    _duration = duration;
    _currentAngle = 0;
    _countDownValue = duration;
    _angleIncrement = 360.0/(float)duration;
    _delegate = delegate;

    _started = NO;

    [self createLabel];

    return self;
}

- (void)dealloc {}

#pragma mark - Public

- (void)start {
    if ((_started)) return;
    _started = YES;
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_duration/360.0
                                                       target:self
                                                     selector:@selector(tickTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    [_animationTimer fire];
}

- (void)restart {
    _started = NO;
    _currentAngle = 0;
    _countDownValue = _duration;
    [self start];
}

#pragma mark - Visual

- (void)createLabel {

    CGFloat labelWidth = self.frame.size.width;

    _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 - labelWidth/2,
                                                                self.frame.size.height/2.0 - labelWidth/2,
                                                                labelWidth,
                                                                labelWidth)];
    _countDownLabel.text = [NSString stringWithFormat:@"%ldsn", (long)_countDownValue];
    _countDownLabel.font = [UIFont fontWithName:@"OpenSans-Regular" size:14];
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
    path1.lineWidth = kKKArcStrokeWidth;
    [path1 stroke];
    [path2 moveToPoint: CGPointMake(startPoint, startPoint)];
    [path2 addLineToPoint: CGPointMake(endPoint, endPoint)];
    [_color setStroke];
    path2.lineWidth = kKKArcStrokeWidth;
    [path2 stroke];
}

#pragma mark - IBActions

- (IBAction)didTap {
    [_closeButton removeTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
    if ([_delegate respondsToSelector:@selector(arcDidTap:)]) {
        [_delegate arcDidTap:self];
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
        if (![_countDownLabel.text isEqualToString:[NSString stringWithFormat:@"%ldsn", (long)_countDownValue]]) {
            [UIView transitionWithView:_countDownLabel
                              duration:.4f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                self->_countDownLabel.text = [NSString stringWithFormat:@"%ldsn", (long)self->_countDownValue];
            } completion:nil];
        }
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    if  (!_animationTimer || !_animationTimer.isValid) {
        //        [self drawCross];
        if ([_delegate respondsToSelector:@selector(arcDidFinish:)])
            [_delegate arcDidFinish:self];
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, rect.size.width/2.0 , rect.size.height/2.0, (rect.size.width-kKKArcStrokeWidth-5)/2, [KKArc radiansForDegrees:-90], [KKArc radiansForDegrees:-90 + _currentAngle], 0);
    CGContextSetStrokeColorWithColor(context, [_color CGColor]);
    CGContextSetLineWidth(context, kKKArcStrokeWidth);
    CGContextStrokePath(context);
}

#pragma mark - Utilities

+ (float)radiansForDegrees:(double)degrees {
    return degrees * M_PI / 180;
}

@end
