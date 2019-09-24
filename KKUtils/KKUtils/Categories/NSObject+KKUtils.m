//
//  NSObject+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSObject+KKUtils.h"
#import "KKIMappable.h"

@implementation NSObject (KKUtils)

- (void)bindValuesOfObject:(NSObject *)object {
    if (/*[self conformsToProtocol:@protocol(KKIMappable)] && */
        [self respondsToSelector:@selector(dataKeyPathsByOutletKeyPath)]) {
        NSDictionary* mapping = [(id<KKIMappable>)self dataKeyPathsByOutletKeyPath];
        for (NSString* key in mapping) {
            [self setValue:[object valueForKeyPath:mapping[key]] forKeyPath:key];
        }
    }
}

@end
