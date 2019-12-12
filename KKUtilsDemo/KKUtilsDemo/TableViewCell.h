//
//  TableViewCell.h
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 2.12.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKUtils/KKUtils.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : KKSlideableTVC
@property (nonatomic, strong) id data;
@end

NS_ASSUME_NONNULL_END
