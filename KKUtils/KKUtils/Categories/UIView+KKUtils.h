//
//  UIView+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KKUtils)

- (void)applySketchShadow:(UIColor *)color
                    alpha:(CGFloat)alpha
                        x:(CGFloat)x
                        y:(CGFloat)y
                     blur:(CGFloat)blur
                   spread:(CGFloat)spread;

- (void)removeSketchShadow;
+ (UIView *)createViewForFrame:(CGRect)frame withColor:(UIColor*)color;
- (void)attachAndLoadXib:(NSString *)xibName;
+ (UIView *)loadFromXib:(NSString *)xibName;
+ (void)addLayoutConstraintsForContainerView:(UIView *)containerView
                                  andSubview:(UIView *)subview
                                 withPadding:(float)padding;
+ (void)addLayoutConstraintsForContainerView:(UIView *)containerView
                                  andSubview:(UIView *)subview
                        withEdgeInsetsString:(NSString*)edgeInsetsString;
+ (void)addLayoutConstraintsForContainerViewToCenterView:(UIView *)containerView
                                              andSubview:(UIView *)subview;
- (void)addLayoutConstraintsToCenterViewInParentView:(UIView *)parentView;
- (void)addWidthAndHeightConstraintsForSize:(CGSize)size
                               inParentView:(UIView *)parentView;
+ (UIView *)loadingOverlay;
- (void)removeAllViews;
+ (UIView *)DarkOverlay;
- (void)showAnimated;
- (void)closeAnimated;

@end
