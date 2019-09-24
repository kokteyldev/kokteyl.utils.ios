//
//  NSDictionary+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KKUtils)

+ (NSDictionary *)dictionaryWithJSONFile:(NSString *)fileName;

@end


