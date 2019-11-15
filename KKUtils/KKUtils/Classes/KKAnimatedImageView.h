//
//  KKAnimatedImageView.h
//  KKUtils
//
//  Created by Tolga Seremet on 14.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKAnimatedImageView : UIView
+ (instancetype)animatedImageViewWithFrame:(CGRect)frame
                                 imageName:(NSString *)imageName
                            numberOfFrames:(NSInteger)numberOfFrames
                         animationDuration:(CGFloat)animationDuration;
@property (nonatomic, strong) IBInspectable NSString *imageName;
@property (nonatomic, assign) IBInspectable NSInteger numberOfFrames;
@property (nonatomic, assign) IBInspectable CGFloat animationDuration;
@end


