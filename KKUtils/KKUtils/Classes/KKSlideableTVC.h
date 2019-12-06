//
//  KKSlideableTVC.h
//  KKUtils
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTableViewCell.h"

@interface KKSlideableTVC : KKTableViewCell
@property (nonatomic, weak) IBOutlet UIView *slideableView;
@property (nonatomic, assign) IBInspectable CGFloat maxSlideDistance;
@property (nonatomic, assign) IBInspectable BOOL isSlidingFromLeft;
@property (nonatomic, assign) IBInspectable BOOL isHapticFeedbackEnabled;
@property (nonatomic, assign) BOOL isPanEnabled;


- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)endEditing;
- (void)startPreviewingSlide;
- (void)stopPreviewingSlide;

@end
