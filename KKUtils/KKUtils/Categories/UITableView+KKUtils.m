//
//  UITableView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UITableView+KKUtils.h"

NSString *const kKKLoadMoreCellIdentifier = @"KKLoadMoreCell";
CGFloat const kKKLoadMoreCellHeight = 50;

@implementation UITableView (KKUtils)

- (void)registerNibs:(NSArray*)nibNames {
    for (NSString* nibName in nibNames) {
        UINib* cellNib = [UINib nibWithNibName:nibName bundle:nil];
        if (cellNib) {
            [self registerNib:cellNib forCellReuseIdentifier:nibName];
        }
    }
}

- (void)registerDefaultNibs {
    [self registerNibs:@[kKKLoadMoreCellIdentifier]];
}

- (void)scrollToTop {
    if (self.numberOfSections > 0) {
        [self setContentOffset:CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN)];
    }
}

- (void)scrollToTopAnimated {
    if (self.numberOfSections > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setContentOffset:CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN) animated:YES];
        });
    }
}

- (void)scrollToBottomWithAnimation:(BOOL)animation {
    [self scrollRectToVisible:CGRectMake(0, self.contentSize.height - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height) animated:animation];
}

- (void)scrollToOffsetY:(CGFloat)offsetY {
    [self scrollRectToVisible:CGRectMake(0, offsetY, self.bounds.size.width, self.frame.size.height) animated:NO];
}

@end
