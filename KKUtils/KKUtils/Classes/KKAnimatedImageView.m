//
//  KKAnimatedImageView.m
//  KKUtils
//
//  Created by Tolga Seremet on 14.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKAnimatedImageView.h"
#import "UIView+KKUtils.h"
#import "UIScreen+KKUtils.h"

@implementation KKAnimatedImageView {
    IBOutlet UIImageView *_animatedImageView;
}

#pragma mark - View lifecycle

+ (instancetype)animatedImageViewWithFrame:(CGRect)frame
                                 imageName:(NSString *)imageName
                            numberOfFrames:(NSInteger)numberOfFrames
                         animationDuration:(CGFloat)animationDuration {

    return [[[self class] alloc] initWithFrame:frame
                                     imageName:imageName
                                numberOfFrames:numberOfFrames
                             animationDuration:animationDuration
            ];
}

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
               numberOfFrames:(NSInteger)numberOfFrames
            animationDuration:(CGFloat)animationDuration {

    if (!(self = [super initWithFrame:frame]))
        return nil;
    _imageName = imageName;
    _numberOfFrames = numberOfFrames;
    _animationDuration = animationDuration;
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    [self commonInit];
    return self;
}

- (void)commonInit {
    [self attachAndLoadXib:NSStringFromClass([self class]) inBundle:@"KKUtilsAssets"];
    [self startAnimation];
}

#pragma mark - Setters

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self startAnimation];
}

- (void)setNumberOfFrames:(NSInteger)numberOfFrames {
    _numberOfFrames = numberOfFrames;
    [self startAnimation];
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    [self startAnimation];
}

#pragma mark - Animation

- (void)startAnimation {

    if (!_imageName || _numberOfFrames == 0 || _animationDuration == 0) { return; }

    NSMutableArray *animationImages = [NSMutableArray new];

    for (int i = 1; i<= _numberOfFrames; i++) {
        [animationImages addObject:
         [UIImage imageNamed:
          [NSString stringWithFormat:@"%@%@.png",_imageName, @(i)]
          ]];
    }

    _animatedImageView.animationRepeatCount = 0;
    _animatedImageView.animationDuration = _animationDuration;
    _animatedImageView.animationImages = [NSArray arrayWithArray:animationImages];
    [_animatedImageView startAnimating];
}

@end
