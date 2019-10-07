//
//  KKUIView.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKUIView : UIView
/**
 @brief Set view corner radius.
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 @brief Set view corner radius to make it look as a circle
 */
@property (nonatomic) IBInspectable BOOL isCircle;
/**
 @brief Set background image name to tile background of view.
 */
@property (nonatomic) IBInspectable NSString* backgroundTileImageName;
/**
 @brief Set border color of view.
 */
@property (nonatomic) IBInspectable UIColor* borderColor;
/**
 @brief Set border width color of view.
 */
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end
