//
//  UIStoryboard+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (KKUtils)

+ (UIStoryboard *)mainStoryboard;
+ (UIStoryboard *)storyboardWithName:(NSString *)name;

@end
