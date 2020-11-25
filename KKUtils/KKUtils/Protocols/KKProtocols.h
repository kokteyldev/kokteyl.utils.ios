//
//  KKProtocols.h
//  KKUtils
//
//  Created by Tolga Seremet on 25.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KKIMappable <NSObject>
@required
- (NSDictionary *)dataKeyPathsByOutletKeyPath;
@end

@protocol KKIIdentifiable <NSObject>
+ (NSString *)identifier;
@end
