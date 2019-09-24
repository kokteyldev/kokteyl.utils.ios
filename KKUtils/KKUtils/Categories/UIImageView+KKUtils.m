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

@dynamic uRL, imageName;

- (void)setURL:(NSString *)uRL {

    uRL =  [uRL stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLQueryAllowedCharacterSet]];

    [NSURLConnection getImageAtURL:uRL success:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    } failure:nil];
}

- (void)setImageName:(NSString *)imageName {
    self.image = [UIImage imageNamed:imageName];
}

@end
