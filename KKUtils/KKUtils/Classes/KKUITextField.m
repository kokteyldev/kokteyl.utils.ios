//
//  KKUITextField.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUITextField.h"
#import "KKMacros.h"

@implementation KKUITextField

#pragma mark - Text Field Utils

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + _edgeInsetLeft , bounds.origin.y,
                      bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark - Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.clipsToBounds = YES;
    [self setNeedsDisplay];
}

- (void)setEdgeInsetLeft:(CGFloat)edgeInsetLeft{
    _edgeInsetLeft = edgeInsetLeft;
    [self setNeedsDisplay];
}

- (void)setLocalizedPlaceholderKey:(NSString *)localizedPlaceholderKey {
    _localizedPlaceholderKey = localizedPlaceholderKey;
    self.placeholder = [getBundle localizedStringForKey:(_localizedPlaceholderKey) value:@"" table:nil];
    [self layoutIfNeeded];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString: self.placeholder
                                    attributes:@{
                                        NSForegroundColorAttributeName: placeholderColor,
                                        NSFontAttributeName : self.font,
                                        NSBaselineOffsetAttributeName : @.75
                                    }];
}

#pragma mark - Protection

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_isProtected &&
        (action == @selector(paste:) ||
         action == @selector(copy:) ||
         action == @selector(selectAll:) ||
         action == @selector(select:) ||
         action == @selector(cut:) ||
         action == @selector(delete:)
         )
        ) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
