//
//  NSURL+KKUtils.m
//  KKUtils
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "NSURL+KKUtils.h"

@implementation NSURL (KKUtils)

- (NSDictionary *)queryItems {
    if (self == nil) return [NSDictionary new];
    
    NSURLComponents *comps = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    
    if (comps) {
        NSMutableDictionary *queryItems = [[NSMutableDictionary alloc] init];
        for (NSURLQueryItem *queryItem in comps.queryItems) {
            [queryItems setObject:queryItem.value forKey:queryItem.name];
        }
        
        return [NSDictionary dictionaryWithDictionary:queryItems];
    }
    
    return [NSDictionary new];
}

@end
