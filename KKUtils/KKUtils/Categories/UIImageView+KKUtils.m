//
//  UIImageView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIImageView+KKUtils.h"
#import "NSURLConnection+KKUtils.h"

@implementation UIImageView (KKUtils)

@dynamic name, uRLString, uRL;

- (void)setName:(NSString *)name {
    self.image = [UIImage imageNamed:name];
}

- (void)setURLString:(NSString *)uRLString {

    uRLString = [uRLString stringByAddingPercentEncodingWithAllowedCharacters:
                 [NSCharacterSet URLQueryAllowedCharacterSet]
                 ];

    [NSURLConnection getImageAtURL:uRLString success:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    } failure:nil];
}

- (void)setURL:(NSURL *)uRL {
    [self setURLString:uRL.absoluteString];
}

@end
