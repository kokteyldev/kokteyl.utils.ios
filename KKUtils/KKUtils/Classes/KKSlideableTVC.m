//
//  KKSlideableTVC.m
//  KKUtils
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKSlideableTVC.h"
#import "UIView+KKUtils.h"

CGFloat const kKKSlideBounceValue = 10.0f;

@interface KKSlideableTVC () <UIGestureRecognizerDelegate> @end

@implementation KKSlideableTVC {

    UIPanGestureRecognizer *_panRecognizer;
    CGPoint _panStartPoint;
    CGFloat _startingConstraintConstant;

    NSLayoutConstraint *_slideableViewConstraint;

    BOOL _isPanInProgress;
    BOOL _isPreviewEnabled;

    UISelectionFeedbackGenerator *_feedbackGenerator;
}

#pragma mark - View lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    _isPanInProgress = NO;
    _isPanEnabled = YES;
    [self activate];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:YES];
}

- (void)setIsPanEnabled:(BOOL)isPanEnabled {
    _isPanEnabled = isPanEnabled;
}

#pragma mark - Activate

- (void)activate {

    if (_isSlidingFromLeft) {
        _slideableViewConstraint = [_slideableView constraintForLayoutAttribute:NSLayoutAttributeLeading];
    } else {
        _slideableViewConstraint = [_slideableView constraintForLayoutAttribute:NSLayoutAttributeTrailing];
    }

    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    _panRecognizer.delegate = self;
    [_slideableView addGestureRecognizer:_panRecognizer];
}

#pragma mark - Pan

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {

    if (!_isPanEnabled) { return; }

    if (_isSlidingFromLeft) {
        switch (recognizer.state) {

            case UIGestureRecognizerStateBegan: {
                _isPanInProgress = YES;
                _panStartPoint = [recognizer translationInView:_slideableView];
                _startingConstraintConstant = _slideableViewConstraint.constant;

                if (_isHapticFeedbackEnabled) {
                    // Instantiate a new generator.
                    _feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
                    [_feedbackGenerator prepare];
                }
                break;
            }

            case UIGestureRecognizerStateChanged: {
                _isPanInProgress = YES;
                CGPoint currentPoint = [recognizer translationInView:_slideableView];
                CGFloat deltaX = currentPoint.x + _panStartPoint.x;
                BOOL panningRight = NO;
                if (currentPoint.x > _panStartPoint.x) {
                    panningRight = YES;
                }

                if (_startingConstraintConstant == 0) {
                    if (!panningRight) {
                        CGFloat constant = MAX(deltaX, 0);
                        if (constant == 0) {
                            [self resetConstraintContstantsToZeroWhileDragging];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    } else {
                        CGFloat constant = MIN(deltaX, _maxSlideDistance);
                        if (constant == _maxSlideDistance) {
                            [self setConstraintsToShowAllButtonsWhileDragging];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    }
                } else {
                    CGFloat adjustment = _startingConstraintConstant + deltaX;
                    if (!panningRight) {
                        CGFloat constant = MAX(adjustment, 0);
                        if (constant == 0) {
                            [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    } else {
                        CGFloat constant = MIN(adjustment, _maxSlideDistance);
                        if (constant == _maxSlideDistance) {
                            [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    }
                }
                break;
            }

            case UIGestureRecognizerStateEnded: {
                _isPanInProgress = NO;
                if (_startingConstraintConstant == 0) {
                    CGFloat halfOfButtonOne = _maxSlideDistance/4;
                    if (_slideableViewConstraint.constant >= halfOfButtonOne) {
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                } else {
                    CGFloat buttonOnePlusHalfOfButton2 = _maxSlideDistance * .75;
                    if (_slideableViewConstraint.constant >= buttonOnePlusHalfOfButton2) {
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                }
                break;
            }

            case UIGestureRecognizerStateCancelled: {
                _isPanInProgress = NO;
                if (_startingConstraintConstant == 0) {
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                } else {
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                }
                break;
            }

            default:
                break;
        }
    } else {

        switch (recognizer.state) {

            case UIGestureRecognizerStateBegan: {
                _isPanInProgress = YES;
                _panStartPoint = [recognizer translationInView:_slideableView];
                _startingConstraintConstant = _slideableViewConstraint.constant;

                if (_isHapticFeedbackEnabled) {
                    // Instantiate a new generator.
                    _feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
                    [_feedbackGenerator prepare];
                }
                break;
            }

            case UIGestureRecognizerStateChanged: {
                _isPanInProgress = YES;
                CGPoint currentPoint = [recognizer translationInView:_slideableView];
                CGFloat deltaX = currentPoint.x - _panStartPoint.x;
                BOOL panningLeft = NO;
                if (currentPoint.x < _panStartPoint.x) {
                    panningLeft = YES;
                }

                if (_startingConstraintConstant == 0) {
                    if (!panningLeft) {
                        CGFloat constant = MAX(-deltaX, 0);
                        if (constant == 0) {
                            [self resetConstraintContstantsToZeroWhileDragging];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    } else {
                        CGFloat constant = MIN(-deltaX, _maxSlideDistance);
                        if (constant == _maxSlideDistance) {
                            [self setConstraintsToShowAllButtonsWhileDragging];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    }
                } else {
                    CGFloat adjustment = _startingConstraintConstant - deltaX;
                    if (!panningLeft) {
                        CGFloat constant = MAX(adjustment, 0);
                        if (constant == 0) {
                            [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    } else {
                        CGFloat constant = MIN(adjustment, _maxSlideDistance);
                        if (constant == _maxSlideDistance) {
                            [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                        } else {
                            _slideableViewConstraint.constant = constant;
                        }
                    }
                }
                break;
            }

            case UIGestureRecognizerStateEnded: {
                _isPanInProgress = NO;
                if (_startingConstraintConstant == 0) {
                    CGFloat halfOfButtonOne = _maxSlideDistance/4;
                    if (_slideableViewConstraint.constant >= halfOfButtonOne) {
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                } else {
                    CGFloat buttonOnePlusHalfOfButton2 = _maxSlideDistance * .75;
                    if (_slideableViewConstraint.constant >= buttonOnePlusHalfOfButton2) {
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                    } else {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                    }
                }
                break;
            }

            case UIGestureRecognizerStateCancelled: {
                _isPanInProgress = NO;
                if (_startingConstraintConstant == 0) {
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                } else {
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                }
                break;
            }

            default:
                break;
        }
    }
}

- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)endEditing {

    if (animated && _isHapticFeedbackEnabled) {
        [_feedbackGenerator selectionChanged];
    }

    if (_startingConstraintConstant == 0 &&
        _slideableViewConstraint.constant == 0) {
        return;
    }

    _slideableViewConstraint.constant = -kKKSlideBounceValue;

    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self->_slideableViewConstraint.constant = 0;
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self->_startingConstraintConstant = self->_slideableViewConstraint.constant;
        }];
    }];
}

- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate {

    if (animated && _isHapticFeedbackEnabled) {
        [_feedbackGenerator selectionChanged];
    }

    if (_startingConstraintConstant == _maxSlideDistance &&
        _slideableViewConstraint.constant == _maxSlideDistance) {
        return;
    }

    _slideableViewConstraint.constant = _maxSlideDistance + kKKSlideBounceValue;

    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self->_slideableViewConstraint.constant = self->_maxSlideDistance;
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self->_startingConstraintConstant = self->_slideableViewConstraint.constant;
        }];
    }];
}

- (void)setConstraintsToShowAllButtonsWhileDragging {

    if (_startingConstraintConstant == _maxSlideDistance &&
        _slideableViewConstraint.constant == _maxSlideDistance) {
        return;
    }

    _slideableViewConstraint.constant = _startingConstraintConstant = _maxSlideDistance;
}

- (void)resetConstraintContstantsToZeroWhileDragging {

    if (_startingConstraintConstant == 0 &&
        _slideableViewConstraint.constant == 0) {
        return;
    }

    _slideableViewConstraint.constant = _startingConstraintConstant = 0;
}

- (void)updateConstraintsIfNeeded:(BOOL)animated
                       completion:(void (^)(BOOL finished))completion {

    float duration = animated ? 0.1 : 0;

    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        [self layoutIfNeeded];
    }
                     completion:completion];
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return !_isPanInProgress;
}

#pragma mark - Preview slide

- (void)startPreviewingSlide {
    _isPreviewEnabled = YES;
    [self performSelector:@selector(previewSlide) withObject:nil afterDelay:1];
}

- (void)stopPreviewingSlide {
    _isPreviewEnabled = NO;
}

- (void)previewSlide {
    if (_isPreviewEnabled) {
        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
        [self performSelector:@selector(closeSlide) withObject:nil afterDelay:1];
    }
}

- (void)closeSlide {
    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
    if (_isPreviewEnabled) {
        [self performSelector:@selector(previewSlide) withObject:nil afterDelay:1];
    }
}

@end
