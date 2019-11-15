//
//  ViewController.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 14.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "ViewController.h"

#import <KKUtils/KKUtils.h>

@implementation ViewController {
    KKAnimatedImageView *animated;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    animated = [KKAnimatedImageView animatedImageViewWithFrame:CGRectMake(100, 100, 50, 50)
                                                     imageName:@"Page "
                                                numberOfFrames:62
                                             animationDuration:1.2];

    [self.view addSubview:animated];



}


@end
