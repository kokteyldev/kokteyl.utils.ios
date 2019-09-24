//
//  UIStoryboard+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIStoryboard+KKUtils.h"

@implementation UIStoryboard (KKUtils)

+ (UIStoryboard *)mainStoryboard {
  return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (UIStoryboard *)storyboardWithName:(NSString *)name {
    return [UIStoryboard storyboardWithName:name bundle:nil];
}

@end
