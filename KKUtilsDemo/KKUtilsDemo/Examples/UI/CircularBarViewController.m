//
//  ArcViewController.m
//  KKUtilsDemo
//
//  Created by Mehmet Karagöz on 17.02.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "CircularBarViewController.h"
#import <KKUtils/KKUtils.h>

@interface CircularBarViewController () <KKCircularBarDelegate> @end

@implementation CircularBarViewController {
    KKCircularBar *_circularBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _circularBar = [KKCircularBar barWithFrame:CGRectMake(0, 100, 50.0, 50.0)
                                         color:[UIColor redColor]
                                      duration:5
                                          font:[UIFont systemFontOfSize:16.0]];
    _circularBar.delegate = self;
    [self.view addSubview:_circularBar];
    [_circularBar start];

    [self notifTest];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self names:@[UIApplicationDidBecomeActiveNotification, UIApplicationWillResignActiveNotification, UIApplicationDidEnterBackgroundNotification] object:nil];
}

- (void)notifTest {
    NSArray<NSNotificationName> *notifNames = @[UIApplicationDidBecomeActiveNotification, UIApplicationWillResignActiveNotification, UIApplicationDidEnterBackgroundNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) names:notifNames object:nil];
}

#pragma mark - <KKCircularBarDelegate>

- (void)circularBarDidTap:(KKCircularBar *)circularBar {
    
}

- (void)circularBarDidFinish:(KKCircularBar *)circularBar {
    [_circularBar stop];
}

#pragma mark - Notification

- (void)handleNotification:(NSNotification *)n {
    NSLog(@"notification recieved: %@", n.name);
}

@end
