//
//  KKNSLayoutConstraintExpandableByKeyboard.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKNSLayoutConstraintExpandableByKeyboard : NSLayoutConstraint

@property (weak, nonatomic) IBOutlet UIViewController* containerViewController;
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;

@end
