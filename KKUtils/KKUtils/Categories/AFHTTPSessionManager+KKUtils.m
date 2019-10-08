//
//  AFHTTPSessionManager+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 8.10.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "AFHTTPSessionManager+KKUtils.h"

@implementation AFHTTPSessionManager (KKUtils)

- (void)addHeaders:(NSDictionary *)headers {
    if (headers && [headers allKeys].count > 0) {
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        for (NSString *key in [headers allKeys]) {
            [requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
        self.requestSerializer = requestSerializer;
    }
}

@end
