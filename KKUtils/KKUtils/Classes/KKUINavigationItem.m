//
//  KKUINavigationItem.m
//  KKUtils
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "KKUINavigationItem.h"

@implementation KKUINavigationItem

- (void)setLocalizedKey:(NSString *)localizedKey {
    _localizedKey = localizedKey;
    self.title = [[NSBundle mainBundle] localizedStringForKey:(_localizedKey) value:@"" table:nil];
}

@end
