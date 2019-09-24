//
//  KKIMappable.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KKIMappable <NSObject>
@required
- (NSDictionary *)dataKeyPathsByOutletKeyPath;
@end

