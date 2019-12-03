//
//  UIViewController+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KKUtils)

- (BOOL)amIOnTop;
- (BOOL)amIOnTopForNonMainStoryboard;
- (BOOL)isViewControllerOnTopKindOfMyClass;
- (BOOL)amIBeingPoppedFromNavigationStack;
- (void)setNavigationbarColor:(UIColor *)color;
- (void)disablePopGestureRecognizer;
- (void)resetBackButtonText;
- (void)showAlertForMessage:(NSString *)message;

+ (UIViewController *)topMostController;
+ (void)presentController:(NSString *)controller fromStoryboard:(NSString *)storyboard;

@end

