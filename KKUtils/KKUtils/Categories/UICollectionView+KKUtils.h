//
//  UICollectionView+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (KKUtils)

- (void)registerNibs:(NSArray *)nibNames;
- (void)registerHeaderNib:(NSString *)headerNibName;
- (void)registerFooterNib:(NSString *)footerNibName;
- (void)registerHeaderNibs:(NSArray *)headerNibNames
                  cellNibs:(NSArray *)cellNibNames
                footerNibs:(NSArray *)footerNibNames;

@end
