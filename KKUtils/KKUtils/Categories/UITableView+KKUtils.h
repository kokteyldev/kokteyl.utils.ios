//
//  UITableView+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kKKLoadMoreCellIdentifier;
extern CGFloat const kKKLoadMoreCellHeight;

@interface UITableView (KKUtils)

- (void)registerNibs:(NSArray *)nibNames;
- (void)registerDefaultNibs;
- (void)scrollToTop;
- (void)scrollToTopAnimated;
- (void)scrollToBottomWithAnimation:(BOOL)animation;
- (void)scrollToOffsetY:(CGFloat)offsetY;

@end
