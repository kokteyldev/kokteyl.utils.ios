//
//  KKUILabel.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUILabel.h"
#import "KKMacros.h"

@implementation KKUILabel

#pragma mark - Initializer

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;

    [self commonInit];

    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    if (!(self = [super initWithCoder:coder]))
        return nil;

    [self commonInit];

    return self;
}

- (void)commonInit {
    self.numberOfLines = 0;
    if (self.clearTextOnInit) {
      self.text = @" ";
    }
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setCharacterSpacing:_characterSpacing];
}

#pragma mark - Setters

- (void)setClearTextOnInit:(BOOL)clearTextOnInit {
    _clearTextOnInit = clearTextOnInit;
    if (clearTextOnInit) {
        self.text = @" ";
    }
}

- (void)setEdgeInsetsString:(NSString *)edgeInsetsString{
    _edgeInsetsString = edgeInsetsString;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.clipsToBounds = YES;
    [self setNeedsDisplay];
}

- (void)setLocalizedKey:(NSString *)localizedKey{
    _localizedKey = localizedKey;
    self.text = [getBundle localizedStringForKey:(_localizedKey) value:@"" table:nil];
    [self layoutIfNeeded];
}

- (void)setRTFFileName:(NSString *)rTFFileName{
    NSURL *url = [getBundle URLForResource:[rTFFileName stringByDeletingPathExtension]
                             withExtension:[rTFFileName pathExtension]];
    NSError *error;

    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithURL:url
                                                                           options:@{NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType}
                                                                documentAttributes:nil
                                                                             error:&error];

    if (!error)
        [self setAttributedText:attributedString];
}

- (void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setCharacterSpacing:(CGFloat)characterSpacing {
    _characterSpacing = characterSpacing;

    if (self.text == nil) return;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];

    [attributedString addAttribute:NSKernAttributeName
                             value:@(_characterSpacing)
                             range:NSMakeRange(0, [self.text length])];

    [self setAttributedText:attributedString];
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = UIEdgeInsetsFromString(self.edgeInsetsString);
    if (self.strokeWidth > 0) {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);

        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [super drawTextInRect:rect];

        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = self.fillColor;
        [super drawTextInRect:rect];
    }
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

#pragma mark - Autolayout content size

- (CGSize) intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize] ;
    UIEdgeInsets insets = UIEdgeInsetsFromString(self.edgeInsetsString);
    superSize.height += insets.top + insets.bottom;
    superSize.width += insets.left + insets.right;
    return superSize ;
}

@end
