//
//  KKUITextView.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "KKUITextView.h"

@interface KKUITextView () <UITextViewDelegate> @end

@implementation KKUITextView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
}

- (BOOL)canBecomeFirstResponder {
    return NO;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (!NSEqualRanges(textView.selectedRange, NSMakeRange(0, 0))) {
        textView.selectedTextRange = nil;
        [textView endEditing:YES];
    }
}

@end
