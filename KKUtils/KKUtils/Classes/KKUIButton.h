//
//  KKUIButton.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKUIButton : UIButton
/**
 @brief Set view corner radius.
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 @brief Set view corner radius to make it look as a circle
 */
@property (nonatomic) IBInspectable BOOL isCircle;
/**
 @brief Set localized key of button.
 */
@property (nonatomic) IBInspectable NSString* localizedKey;
/**
 @brief Set title of button.
 */
@property (nonatomic) NSString* title;
/**
 @brief Set left padding of image of button.
 */
@property (nonatomic) IBInspectable CGFloat iconImageTopPadding;
/**
 @brief Set left padding of image of button.
 */
@property (nonatomic) IBInspectable CGFloat iconImageLeftPadding;
/**
 @brief Set right padding of image of button.
 */
@property (nonatomic) IBInspectable CGFloat iconImageRightPadding;
/**
 @brief Set image of button.
 */
@property (nonatomic) IBInspectable NSString* iconImage;
/**
 @brief custom selected value for not to change the appearence of button
 */
@property (nonatomic) BOOL isSelectedCustom;
/**
 @brief Set border color of view.
 */
@property (nonatomic) IBInspectable UIColor* borderColor;
/**
 @brief Set border width color of view.
 */
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end
