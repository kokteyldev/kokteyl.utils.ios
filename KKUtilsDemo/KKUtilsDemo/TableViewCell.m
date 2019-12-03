//
//  TableViewCell.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell {
    IBOutlet UILabel *LBLName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name {
    LBLName.text = name;
}

@end
