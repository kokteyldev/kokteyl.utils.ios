//
//  KKUITabBarItem.m
//  KKUtils
//
//  Created by Tolga Seremet on 7.04.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "KKUITabBarItem.h"

@implementation KKUITabBarItem
- (void)setLocalizedKey:(NSString *)localizedKey {
    _localizedKey = localizedKey;
    [self setTitle:NSLocalizedString(localizedKey, nil)];
}
@end
