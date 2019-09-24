//
//  KKArc.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//
//  KKArc *arc = [KKArc arcWithLocation:KKArcLocationLeft
//                                color:[UIColor colorWithRed:1 green:1 blue:1 alpha:.75]
//                             duration:4
//                             delegate:self];
//
//  NSDictionary *options = @{
//                            @"KKArcLocation" : @1,
//                            @"KKArcColor" : @"#0000FF",
//                            @"KKArcAlpha": @.8,
//                            @"KKArcDuration" : @6
//                            };
//
//  KKArc *arc = [KKArc arcWithDictionary:options delegate:self];
//
//  [self.view addSubview:arc];
//  [arc start];

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, KKArcLocation){
    KKArcLocationRight = 0,
    KKArcLocationLeft
};

@class KKArc;
@protocol KKArcDelegate <NSObject>
@optional
- (void)arcDidTap:(KKArc *)arc;
- (void)arcDidFinish:(KKArc *)arc;
@end

@interface KKArc : UIView

+ (instancetype)arcWithDictionary:(NSDictionary *)options
                         delegate:(id<KKArcDelegate>)delegate;

+ (instancetype)arcWithLocation:(KKArcLocation)location
                          color:(UIColor *)color
                       duration:(NSInteger)duration
                       delegate:(id<KKArcDelegate>)delegate;
- (void)start;
- (void)restart;

@end

