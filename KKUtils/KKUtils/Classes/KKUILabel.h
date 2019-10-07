//
//  KKUILabel.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKUILabel : UILabel
/**
 @brief Setup label padding in following string format "{top, left, bottom, right}" @"{0.0,0.0,0.0,0.0}".
 */
@property (nonatomic) IBInspectable NSString* edgeInsetsString;
/**
 @brief Set view corner radius.
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 @brief Set localized key of label.
 */
@property (nonatomic) IBInspectable NSString* localizedKey;
/**
 @brief Set filename for RTF text.
 */
@property (nonatomic) IBInspectable NSString* rTFFileName;
/**
 @brief Set stroke width of label.
 */
@property (nonatomic) IBInspectable CGFloat strokeWidth;
/**
 @brief Set stroke color of label.
 */
@property (nonatomic) IBInspectable UIColor* strokeColor;
/**
 @brief Set stroke color of label.
 */
@property (nonatomic) IBInspectable UIColor* fillColor;
/**
 @brief set character spacing of label.
 */
@property (nonatomic) IBInspectable CGFloat characterSpacing;
/**
 @brief clear text in xib on init.
 */
@property (nonatomic) IBInspectable BOOL clearTextOnInit;

@end
