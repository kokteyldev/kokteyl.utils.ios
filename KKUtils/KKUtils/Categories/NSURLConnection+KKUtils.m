//
//  NSURLConnection+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnection+KKUtils.h"

@implementation NSURLConnection (KKUtils)

+ (void)getImageAtURL:(NSString *)URL
              success:(void (^)(UIImage *image))success
              failure:(void (^)(NSError *error))failure {

    [NSURLConnection getRequestForUrl:URL parameters:nil headers:nil success:^(NSData *data) {
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            success(image);
        } else {
            NSDictionary* errorDetails = @{NSLocalizedDescriptionKey:@"No image found"};
            NSError *error = [NSError errorWithDomain:@"KKUtils" code:404 userInfo:errorDetails];
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getRequestForUrl:(NSString *)URL
              parameters:(NSDictionary *)parameters
                 headers:(NSDictionary *)headers
                 success:(void (^)(NSData *data))success
                 failure:(void (^)(NSError *error))failure {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = headers;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];

    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if (error) {
                                                           failure(error);
                                                       } else {
                                                           if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                               NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                               if (httpResponse.statusCode == 200) {
                                                                   success(data);
                                                               } else {
                                                                   NSDictionary* errorDetails = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Server returned status code:%@", @(httpResponse.statusCode)]};
                                                                   NSError *error = [NSError errorWithDomain:@"KKUtils" code:httpResponse.statusCode userInfo:errorDetails];
                                                                   failure(error);
                                                               }
                                                           } else {
                                                               NSDictionary* errorDetails = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Unknown response from server"]};
                                                               NSError *error = [NSError errorWithDomain:@"KKUtils" code:-1 userInfo:errorDetails];
                                                               failure(error);
                                                           }
                                                       }
                                                   }];
    [getDataTask resume];
}

@end
