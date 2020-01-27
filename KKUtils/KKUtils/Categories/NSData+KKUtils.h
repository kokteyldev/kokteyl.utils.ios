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

- (NSData *)KKAES128EncryptedDataWithKey:(NSString *)key;
- (NSData *)KKAES128DecryptedDataWithKey:(NSString *)key;
- (NSData *)KKAES128EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;
- (NSData *)KKAES128DecryptedDataWithKey:(NSString *)key iv:(NSString *_Nullable)iv;

- (NSData *)KKAES256EncryptedDataWithKey:(NSString *)key;
- (NSData *)KKAES256DecryptedDataWithKey:(NSString *)key;
- (NSData *)KKAES256EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;
- (NSData *)KKAES256DecryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv;

- (NSString *)KKHexadecimalString;

@end

NS_ASSUME_NONNULL_END
