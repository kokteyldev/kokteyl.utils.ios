//
//  KKRefreshControl.h
//  KKUtils
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKRefreshControl : UIRefreshControl
+ (instancetype)refreshControlWithImageBaseName:(NSString *)imageBaseName
                                startImageIndex:(NSInteger)startImageIndex
                                  endImageIndex:(NSInteger)endImageIndex
                                   spinnerWidth:(CGFloat)spinnerWidth
                              animationDuration:(NSTimeInterval)animationDuration;
@end


