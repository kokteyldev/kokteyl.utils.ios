//
//  KKUINavigationItem.h
//  KKUtils
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKUINavigationItem : UINavigationItem
/**
 @brief Set localized key of navigation item.
 */
@property (nonatomic) IBInspectable NSString* localizedKey;
@end

NS_ASSUME_NONNULL_END
