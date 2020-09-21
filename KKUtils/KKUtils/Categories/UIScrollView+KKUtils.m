//
//  UIScrollView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 21.09.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "UIScrollView+KKUtils.h"

@implementation UIScrollView (KKUtils)

- (void)scrollToBottom:(BOOL)animated {
    CGPoint bottomOffset = CGPointMake(0, self.contentSize.height - self.bounds.size.height + self.contentInset.bottom);
    if (bottomOffset.y >= 0) {
        [self setContentOffset:bottomOffset animated:animated];
    }
}

@end
