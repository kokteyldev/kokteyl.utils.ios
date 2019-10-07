//
//  UIImageView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIImageView+KKUtils.h"
#import "UIImageView+AFNetworking.h"


@implementation UIImageView (KKUtils)

@dynamic name, uRLString, uRL;

- (void)setName:(NSString *)name {
    self.image = [UIImage imageNamed:name];
}

- (void)setURLString:(NSString *)uRLString {

    uRLString = [uRLString stringByAddingPercentEncodingWithAllowedCharacters:
                 [NSCharacterSet URLQueryAllowedCharacterSet]
                 ];

    if (uRLString != nil) {
        [self setImageWithURL:[NSURL URLWithString:uRLString]];
    }
}

- (void)setURL:(NSURL *)uRL {
    [self setImageWithURL:uRL];
}

@end
