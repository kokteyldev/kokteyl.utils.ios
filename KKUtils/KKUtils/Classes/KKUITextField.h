//
//  KKUITextField.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKUITextField : UITextField
/**
 @brief Set localized placeholder key of textField.
 */
@property (nonatomic) IBInspectable NSString* localizedPlaceholderKey;
/**
 @brief Set textfield corner radius.
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 @brief Setup UITextField text padding for left.
 */
@property (nonatomic) IBInspectable CGFloat edgeInsetLeft;
/**
 @brief Set textfield as protected. User interaction is enabled but text cannot be interacted.
*/
@property (nonatomic) IBInspectable BOOL isProtected;
/**
@brief Set color of  placeholder text.
*/
@property (nonatomic) IBInspectable UIColor *placeholderColor;

@end


