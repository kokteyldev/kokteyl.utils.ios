//
//  NSURLConnection+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSURLConnection (KKUtils)

+ (void)getImageAtURL:(NSString *)URL
              success:(void (^)(UIImage *image))success
              failure:(void (^)(NSError *error))failure;

+ (void)getRequestForUrl:(NSString *)URL
              parameters:(NSDictionary *)parameters
                 headers:(NSDictionary *)headers
                 success:(void (^)(NSData *data))success
                 failure:(void (^)(NSError *error))failure;

@end
