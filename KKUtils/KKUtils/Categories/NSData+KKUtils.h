//
//  NSData+KKUtils.h
//  KKUtils
//
//  Created by Mehmet Karagöz on 21.10.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KKUtils)

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *_Nullable)iv;

- (NSData *)AES256EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES256DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES256EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;
- (NSData *)AES256DecryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;

- (NSString *)hexadecimalString;

@end

NS_ASSUME_NONNULL_END
