//
//  NSMutableString+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 2.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "NSMutableString+KKUtils.h"

@implementation NSMutableString (KKUtils)
- (void)appendStringAfterNewLine:(NSString *)aString {
    [self appendString:@"\n"];
    [self appendString:aString];
}
@end
