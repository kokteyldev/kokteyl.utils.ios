//
//  UIView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIView+KKUtils.h"
#import "UIColor+KKUtils.h"

@implementation UIView (KKUtils)

- (void)applySketchShadow:(UIColor *)color
                    alpha:(CGFloat)alpha
                        x:(CGFloat)x
                        y:(CGFloat)y
                     blur:(CGFloat)blur
                   spread:(CGFloat)spread {

    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOpacity = alpha;
    self.layer.shadowOffset = CGSizeMake(x, y);
    self.layer.shadowRadius = blur / 2.0f;
    if (spread == 0) {
        self.layer.shadowPath = nil;
    } else {
        CGFloat dx = -spread;
        CGRect rect = CGRectOffset(self.layer.bounds, dx, dx);
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:rect] CGPath];
    }
}

- (void)removeSketchShadow {
    self.layer.shadowColor = nil;
    self.layer.shadowOpacity = 0;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = CGFLOAT_MIN;
    self.layer.shadowPath = nil;
}

+ (UIView *)createViewForFrame:(CGRect)frame withColor:(UIColor*)color {
    UIView* view = [[UIView alloc]initWithFrame:frame];
    [view setBackgroundColor:color];
    return view;
}

- (void)attachAndLoadXib:(NSString*)xibName {
    NSBundle* mainBundle = [NSBundle bundleForClass:[self class]];
    NSArray *loadedViews = [mainBundle loadNibNamed:xibName owner:self options:nil];
    UIView *loadedSubview = [loadedViews firstObject];
    [self addSubview:loadedSubview];
    [UIView addLayoutConstraintsForContainerView:self andSubview:loadedSubview withPadding:0];
}

+ (UIView*)loadFromXib:(NSString*)xibName {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSArray *loadedViews = [mainBundle loadNibNamed:xibName owner:self options:nil];
    return [loadedViews firstObject];
}

+ (void)addLayoutConstraintsForContainerView:(UIView*)containerView
                                  andSubview:(UIView*)subview
                                 withPadding:(float)padding{

    subview.translatesAutoresizingMaskIntoConstraints = NO;

    long constraintsArray[4] = {
        NSLayoutAttributeTop,
        NSLayoutAttributeRight,
        NSLayoutAttributeBottom,
        NSLayoutAttributeLeft};

    float paddingsArray[4] = {-padding,padding,padding,-padding};

    for (int i = 0; i < 4; i++) {
        [containerView addConstraint:
         [NSLayoutConstraint constraintWithItem:containerView
                                      attribute:constraintsArray[i]
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:subview
                                      attribute:constraintsArray[i]
                                     multiplier:1.0
                                       constant:paddingsArray[i]]
         ];
    }
}

+ (void)addLayoutConstraintsForContainerView:(UIView*)containerView
                                  andSubview:(UIView*)subview
                        withEdgeInsetsString:(NSString*)edgeInsetsString{

    subview.translatesAutoresizingMaskIntoConstraints = NO;

    UIEdgeInsets edgeInsets = UIEdgeInsetsFromString(edgeInsetsString);

    long constraintsArray[4] = {
        NSLayoutAttributeTop,
        NSLayoutAttributeRight,
        NSLayoutAttributeBottom,
        NSLayoutAttributeLeft};

    float paddingsArray[4] = {-edgeInsets.top, edgeInsets.right, edgeInsets.bottom, -edgeInsets.left};

    for (int i = 0; i < 4; i++) {
        [containerView addConstraint:
         [NSLayoutConstraint constraintWithItem:containerView
                                      attribute:constraintsArray[i]
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:subview
                                      attribute:constraintsArray[i]
                                     multiplier:1.0
                                       constant:paddingsArray[i]]
         ];
    }
}

+ (void)addLayoutConstraintsForContainerViewToCenterView:(UIView *)containerView
                                              andSubview:(UIView *)subview {

    subview.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *constraintCoordinatesCenterX =[NSLayoutConstraint
                                                       constraintWithItem:containerView
                                                       attribute:NSLayoutAttributeCenterX
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:subview
                                                       attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                       constant:1];

    NSLayoutConstraint *constraintCoordinatesCenterY =[NSLayoutConstraint
                                                       constraintWithItem:containerView
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:subview
                                                       attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                       constant:1];

    [containerView addConstraint: constraintCoordinatesCenterX];
    [containerView addConstraint: constraintCoordinatesCenterY];
}

- (void)addLayoutConstraintsToCenterViewInParentView:(UIView*)parentView {

    self.translatesAutoresizingMaskIntoConstraints = NO;

    [parentView addConstraint:[NSLayoutConstraint
                               constraintWithItem:parentView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeCenterX
                               multiplier:1.0
                               constant:1]];

    [parentView addConstraint:[NSLayoutConstraint
                               constraintWithItem:parentView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeCenterY
                               multiplier:1.0
                               constant:1]];
}

- (void)addWidthAndHeightConstraintsForSize:(CGSize)size inParentView:(UIView*)parentView {

    self.translatesAutoresizingMaskIntoConstraints = NO;

    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0
                                                            constant:size.width]];

    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0
                                                            constant:size.height]];
}

+ (UIView*)loadingOverlay {
    UIView* overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlayView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" andAlpha:.4];
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator startAnimating];
    [overlayView addSubview:activityIndicator];
    [UIView addLayoutConstraintsForContainerViewToCenterView:overlayView andSubview:activityIndicator];
    return overlayView;
}

- (void)removeAllViews {
    for (UIView* subview in self.subviews) {
        [subview removeAllViews];
    }
    [self removeFromSuperview];
}

+ (UIView *)DarkOverlay {
    UIView* overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlayView.backgroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:.65];
    return overlayView;
}

- (void)showAnimated {
    self.alpha = 0;
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 1;
    }];
}

- (void)closeAnimated {
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end