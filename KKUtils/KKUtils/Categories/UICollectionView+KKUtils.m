//
//  UICollectionView+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UICollectionView+KKUtils.h"

@implementation UICollectionView (KKUtils)

- (void)registerNibs:(NSArray*)nibNames {
    for (NSString* nibName in nibNames) {
        UINib* cellNib = [UINib nibWithNibName:nibName bundle:nil];
        if (cellNib) {
            [self registerNib:cellNib forCellWithReuseIdentifier:nibName];
        }
    }
}

- (void)registerHeaderNib:(NSString*)headerNibName {
    [self registerNib:[UINib nibWithNibName:headerNibName bundle:nil]
forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
  withReuseIdentifier:headerNibName];
}

- (void)registerFooterNib:(NSString*)footerNibName {
    [self registerNib:[UINib nibWithNibName:footerNibName bundle:nil]
forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
  withReuseIdentifier:footerNibName];
}

- (void)registerHeaderNibs:(NSArray*)headerNibNames
                  cellNibs:(NSArray*)cellNibNames
                footerNibs:(NSArray*)footerNibNames {
    for (NSString* headerNibName in headerNibNames) {
        [self registerHeaderNib:headerNibName];
    }
    [self registerNibs:cellNibNames];
    for (NSString* footerNibName in footerNibNames) {
        [self registerFooterNib:footerNibName];
    }
}

@end
