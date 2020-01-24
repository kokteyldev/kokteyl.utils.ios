//
//  UIApplication+KKUtils.m
//  KKUtils
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "UIApplication+KKUtils.h"

@implementation UIApplication (KKUtils)

+ (void)setRootViewController:(UIViewController *)vc animated:(BOOL)animated {
    if (!vc) return;
    
    if (!animated) {
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        return;
    }
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone animations:^{
        BOOL oldState = UIView.areAnimationsEnabled;
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
}

@end
