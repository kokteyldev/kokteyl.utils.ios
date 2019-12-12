//
//  NSObject+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSObject+KKUtils.h"
#import "KKIMappable.h"
#import "AFHTTPSessionManager.h"

@implementation NSObject (KKUtils)

- (void)bindValuesOfObject:(NSObject *)object {
    if (!object) {
        return;
    }
    if (/*[self conformsToProtocol:@protocol(KKIMappable)] && */
        [self respondsToSelector:@selector(dataKeyPathsByOutletKeyPath)]) {
        NSDictionary* mapping = [(id<KKIMappable>)self dataKeyPathsByOutletKeyPath];
        for (NSString* key in mapping) {
            id subObject = [object valueForKeyPath:mapping[key]];
            if (subObject) {
                [self setValue:subObject forKeyPath:key];
            }
        }
    }
}

- (void)addHeaders:(NSDictionary *)headers {
    if ([self isKindOfClass:[AFHTTPSessionManager class]]) {
        if (headers && [headers allKeys].count > 0) {
            for (NSString *key in [headers allKeys]) {
                [((AFHTTPSessionManager *) self).requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            }
        }
    }
}

@end
