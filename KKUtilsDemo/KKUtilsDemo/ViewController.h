//
//  ViewController.h
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 14.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@end

@interface CustomObject:NSObject
@property (nonatomic, strong) NSString *name;
+ (instancetype)customObjectWithName:(NSString *)name;
@end

