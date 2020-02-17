//
//  KKCircularBar.h
//  KKUtilsDemo
//
//  Created by Mehmet Karagöz on 17.02.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KKCircularBar;
@protocol KKCircularBarDelegate <NSObject>
@optional
- (void)circularBarDidTap:(KKCircularBar *)circularBar;
- (void)circularBarDidFinish:(KKCircularBar *)circularBar;
@end

@interface KKCircularBar : UIView
@property (nonatomic, weak) id <KKCircularBarDelegate> delegate;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat strokeWidth;

@property (nonatomic, strong) IBInspectable UIColor *color;
@property (nonatomic, assign) IBInspectable NSInteger duration;

+ (instancetype)barWithFrame:(CGRect)frame
                       color:(UIColor *)color
                    duration:(NSInteger)duration
                        font:(UIFont *)font;

- (void)start;
- (void)stop;
- (void)restart;
@end

NS_ASSUME_NONNULL_END
