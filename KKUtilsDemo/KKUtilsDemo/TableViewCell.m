//
//  TableViewCell.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell () <KKIMappable> @end

@implementation TableViewCell {
    IBOutlet UILabel *LBLName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isHapticFeedbackEnabled = NO;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(id)data {
    _data = data;
    [self bindValuesOfObject:data];
}

#pragma mark - <KKIMappable>

- (NSDictionary *)dataKeyPathsByOutletKeyPath {
    return @{
        @"LBLName.text" : @"name"
    };
}

@end
