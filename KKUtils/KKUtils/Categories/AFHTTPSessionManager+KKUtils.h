//
//  AFHTTPSessionManager+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 8.10.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <Foundation/Foundation.h>

@interface AFHTTPSessionManager (KKUtils)
- (void)addHeaders:(NSDictionary *)headers;
@end

