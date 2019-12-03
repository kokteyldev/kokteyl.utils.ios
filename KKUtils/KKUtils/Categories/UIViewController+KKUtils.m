//
//  UIViewController+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIViewController+KKUtils.h"
#import "UIImage+KKUtils.h"
#import "UIStoryboard+KKUtils.h"
#import <SafariServices/SafariServices.h>

@implementation UIViewController (KKUtils)

- (BOOL)amIOnTop {

    UITabBarController* tabbarController = (UITabBarController*)((UIWindow*)[UIApplication sharedApplication].windows[0]).rootViewController;

    if ([tabbarController isKindOfClass:[SFSafariViewController class]])
        return NO;

    UIViewController* selectedViewController = ((UINavigationController*)tabbarController.selectedViewController).topViewController;
    if  (selectedViewController.presentedViewController == nil) {
        return [selectedViewController isEqual:self];
    } else if ([selectedViewController.presentedViewController isKindOfClass:[UINavigationController class]]){
        UIViewController* presentedLastViewController = ((UINavigationController*)selectedViewController.presentedViewController).topViewController;
        return [presentedLastViewController isEqual:self];
    } else {
        return [selectedViewController.presentedViewController isEqual:self];
    }
}

- (BOOL)amIOnTopForNonMainStoryboard {
    UINavigationController *navController = (UINavigationController*)((UIWindow*)[UIApplication sharedApplication].windows[0]).rootViewController;
    if  (navController.presentedViewController == nil) {
        return [navController.topViewController isEqual:self];
    } else if ([navController.presentedViewController isKindOfClass:[UINavigationController class]]){
        UIViewController* presentedLastViewController = ((UINavigationController*)navController.presentedViewController).topViewController;
        return [presentedLastViewController isEqual:self];
    } else {
        return [navController.presentedViewController isEqual:self];
    }
}

- (BOOL)isViewControllerOnTopKindOfMyClass {
    UITabBarController* tabbarController =  (UITabBarController*)((UIWindow*)[UIApplication sharedApplication].windows[0]).rootViewController;
    UIViewController* selectedViewController = ((UINavigationController*)tabbarController.selectedViewController).topViewController;
    if  (selectedViewController.presentedViewController == nil) {
        return [selectedViewController isKindOfClass:[self class]];
    } else if ([selectedViewController.presentedViewController isKindOfClass:[UINavigationController class]]){
        UIViewController* presentedLastViewController = ((UINavigationController*)selectedViewController.presentedViewController).topViewController;
        return [presentedLastViewController isKindOfClass:[self class]];
    } else {
        return [selectedViewController.presentedViewController isKindOfClass:[self class]];
    }
}

- (BOOL)amIBeingPoppedFromNavigationStack {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if ([viewControllers indexOfObject:self] == NSNotFound) {
        return YES;
    }
    return NO;
}

- (void)setNavigationbarColor:(UIColor*)color {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:color
                                                                                forSize:CGSizeMake(50, 50)]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
}

- (void)disablePopGestureRecognizer {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

- (void)resetBackButtonText {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)showAlertForMessage:(NSString *)message {

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Dikkat"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"tamam"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];

    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)topMostController {
    return [UIViewController topMostControllerForRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topMostControllerForRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[SFSafariViewController class]])
        return rootViewController;

    if (rootViewController.presentedViewController) {
        return [UIViewController topMostControllerForRootViewController:rootViewController.presentedViewController];
    } else  if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        if ([((UITabBarController *)rootViewController).selectedViewController isKindOfClass:[UINavigationController class]]) {
            return [UIViewController topMostControllerForRootViewController:((UINavigationController *)((UITabBarController *)rootViewController).selectedViewController).topViewController];
        } else {
            return ((UITabBarController *)rootViewController).selectedViewController;
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return [UIViewController topMostControllerForRootViewController:((UINavigationController *)rootViewController).topViewController];
    }
    else {
        return rootViewController;
    }
}

+ (void)presentController:(NSString *)controller fromStoryboard:(NSString *)storyboard {
    UINavigationController *nc = [[UIStoryboard storyboardWithName:storyboard] instantiateViewControllerWithIdentifier:controller];
    nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    nc.modalPresentationStyle = UIModalPresentationFullScreen;

    [[UIViewController topMostController] presentViewController:nc animated:YES completion:nil];
}


@end
