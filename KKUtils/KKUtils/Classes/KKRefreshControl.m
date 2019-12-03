//
//  KKRefreshControl.m
//  KKUtils
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKRefreshControl.h"
#import "UIScreen+KKUtils.h"

@implementation KKRefreshControl {

    NSString *_imageBaseName;
    NSInteger _startImageIndex;
    NSInteger _endImageIndex;
    CGFloat _spinnerWidth;
    NSTimeInterval _animationDuration;

    UIView *_coverView;
    UIImageView *_animatedImageView;
    NSArray *_animationImages;

    BOOL _didSetUp;
}

#pragma mark - View Lifecycle

+ (instancetype)refreshControlWithImageBaseName:(NSString *)imageBaseName
                                startImageIndex:(NSInteger)startImageIndex
                                  endImageIndex:(NSInteger)endImageIndex
                                   spinnerWidth:(CGFloat)spinnerWidth
                              animationDuration:(NSTimeInterval)animationDuration {

    return [[[self class] alloc] initWithImageBaseName:imageBaseName
                                       startImageIndex:startImageIndex
                                         endImageIndex:endImageIndex
                                          spinnerWidth:spinnerWidth
                                     animationDuration:animationDuration];
}

- (instancetype)initWithImageBaseName:(NSString *)imageBaseName
                      startImageIndex:(NSInteger)startImageIndex
                        endImageIndex:(NSInteger)endImageIndex
                         spinnerWidth:(CGFloat)spinnerWidth
                    animationDuration:(NSTimeInterval)animationDuration {
    if (!(self = [super init]))
        return nil;

    _imageBaseName = imageBaseName;
    _startImageIndex = startImageIndex;
    _endImageIndex = endImageIndex;
    _spinnerWidth = spinnerWidth;
    _animationDuration = animationDuration;

    return self;
}

- (instancetype)init {
    if (!(self = [super init]))
        return nil;
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self setupVisual];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - Visual

- (void)setupVisual {
    if (_didSetUp) { return; }
    _didSetUp = YES;

    _coverView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [UIScreen width], self.bounds.size.height)];
    _coverView.backgroundColor = self.superview.backgroundColor;
    [self addSubview:_coverView];

    CGFloat x = .5 * ([UIScreen width] - _spinnerWidth);
    CGFloat y = .5 * (self.bounds.size.height - _spinnerWidth);

    _animatedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, _spinnerWidth, _spinnerWidth)];

    [self addSubview:_animatedImageView];

    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:NULL];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        [self updateForFrameChange];
    }
}

#pragma mark - Actions

- (void)beginRefreshing {
    [super beginRefreshing];
    [self startAnimatingImages];
}

- (void)endRefreshing {
    [super endRefreshing];
}

- (void)startAnimatingImages {
    _animatedImageView.animationImages = [self animationImages];
    _animatedImageView.animationRepeatCount = 0;
    _animatedImageView.animationDuration = _animationDuration;
    [_animatedImageView startAnimating];
}

- (NSArray *)animationImages {
    static NSArray *animationImages = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *animationImagesM = [NSMutableArray new];

        for (NSInteger i = _startImageIndex; i<= _endImageIndex; i++) {
            [animationImagesM addObject:
             [UIImage imageNamed: [NSString stringWithFormat:_imageBaseName, @(i)] ]];
        }
        animationImages = [NSArray arrayWithArray:animationImagesM];
    });
    return animationImages;
}

- (void)updateForFrameChange {

    if (self.isRefreshing) {
        if (!_animatedImageView.isAnimating) {
            [self startAnimatingImages];
        }
    } else {
        [_animatedImageView stopAnimating];

        CGFloat pullDistance = MAX(0.0, -self.frame.origin.y);
        NSInteger i = MAX(_startImageIndex,
                          MIN(_endImageIndex, (pullDistance - (_endImageIndex - _startImageIndex))/3)
                          );

        [_animatedImageView setImage:
         [UIImage imageNamed:
          [NSString stringWithFormat:_imageBaseName, @(i)]
          ]];
    }
}

@end
