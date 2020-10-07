//
//  UILabel+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 7.10.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "UILabel+KKUtils.h"

@implementation UILabel (KKUtils)
@dynamic visible;

- (void)setVisible:(BOOL)visible {
    self.hidden = !visible;
}
@end
