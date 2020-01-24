//
//  KKUINavigationItem.m
//  KKUtils
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "KKUINavigationItem.h"

@implementation KKUINavigationItem

- (void)setLocalizedTitleKey:(NSString *)localizedTitleKey {
    _localizedTitleKey = localizedTitleKey;
    self.title = [[NSBundle mainBundle] localizedStringForKey:(_localizedTitleKey) value:@"" table:nil];
}

@end
