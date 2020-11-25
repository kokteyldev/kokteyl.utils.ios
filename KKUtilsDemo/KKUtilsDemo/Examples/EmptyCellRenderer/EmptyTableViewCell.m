//
//  EmptyTableViewCell.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 25.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "EmptyTableViewCell.h"


@implementation EmptyTableViewCell {
    IBOutlet UILabel *LBLInfo;
    __weak id<KKEmptyTableRendererDelegate> _delegate;
}

#pragma mark - IBActions

- (IBAction)performEmptyAction {
    if (_delegate && [_delegate respondsToSelector:@selector(emptyTableRendererDidRequestNewItem)]) {
        [_delegate emptyTableRendererDidRequestNewItem];
    }
}

#pragma mark - <KKEmptyTableRendererCellDelegate>

- (void)setDelegate:(id<KKEmptyTableRendererDelegate>)delegate {
    _delegate = delegate;
}

- (void)setData:(id)data {
    LBLInfo.text = data;
}

+ (CGFloat)height {
    return 190;
}

#pragma mark - <KKIIdentifiable>

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
