//
//  ArcViewController.m
//  KKUtilsDemo
//
//  Created by Mehmet Karagöz on 17.02.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "CircularBarViewController.h"
#import <KKUtils/KKUtils.h>

@interface CircularBarViewController () <KKCircularBarDelegate>

@end

@implementation CircularBarViewController {
    KKCircularBar *_circularBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _circularBar = [KKCircularBar barWithFrame:CGRectMake(0, 100, 50.0, 50.0)
                                         color:[UIColor redColor]
                                      duration:30
                                          font:[UIFont systemFontOfSize:16.0]];
    _circularBar.delegate = self;
    [self.view addSubview:_circularBar];
    [_circularBar start];
}

#pragma mark - <KKCircularBarDelegate>

- (void)circularBarDidTap:(KKCircularBar *)circularBar {
    
}

- (void)circularBarDidFinish:(KKCircularBar *)circularBar {
    [_circularBar stop];
}

@end
