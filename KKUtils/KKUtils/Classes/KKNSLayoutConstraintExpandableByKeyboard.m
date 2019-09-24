//
//  KKNSLayoutConstraintExpandableByKeyboard.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKNSLayoutConstraintExpandableByKeyboard.h"
#import "UIScreen+KKUtils.h"

@interface KKNSLayoutConstraintExpandableByKeyboard() <UIScrollViewDelegate> @end

@implementation KKNSLayoutConstraintExpandableByKeyboard {
    CGFloat _initalConstant;
}

- (void)awakeFromNib{
    // Subscribe to keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _initalConstant =  self.constant;
    self.scrollView.delegate = self;
    [super awakeFromNib];
}

- (instancetype)init{
    if (!(self = [super init])) {
        return nil;
    }

    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

    self.scrollView.delegate = nil;
}

#pragma mark - Keyboard delegate

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:animationDuration animations:^{
        self.constant = self->_initalConstant;
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;

    if (self.scrollView) {
        //if container bottom space is not 0
        CGFloat bottomPointOfView = [UIScreen height] - (self.scrollView.frame.size.height + self.scrollView.frame.origin.y);

        if (height > bottomPointOfView && _initalConstant == self.constant) {
            self.constant = height - bottomPointOfView;

            CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height);
            [self.scrollView setContentOffset:bottomOffset animated:NO];
        }
    } else {
        //if container bottom space is above tabbar
        if (!self.containerViewController.hidesBottomBarWhenPushed) {
            height-=_containerViewController.tabBarController.tabBar.bounds.size.height;
        } else {
            //if container bottom space is 0
        }
        self.constant = height;
    }

    [UIView animateWithDuration:animationDuration animations:^{
        [self.containerViewController.view layoutIfNeeded];
    }];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];

    if(translation.y > 10)
        [self.containerViewController.view endEditing:YES];
}

@end
