//
//  NSData+KKUtils.m
//  KKUtils
//
//  Created by Mehmet Karagöz on 21.10.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "NSData+KKUtils.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (KKUtils)

- (NSData *)KKAES128EncryptedDataWithKey:(NSString *)key {
    return [self KKAES128EncryptedDataWithKey:key iv:nil];
}

- (NSData *)KKAES128DecryptedDataWithKey:(NSString *)key {
    return [self KKAES128DecryptedDataWithKey:key iv:nil];
}

- (NSData *)KKAES128EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv {
    return [self AES128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)KKAES128DecryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv {
    return [self AES128Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)KKAES256EncryptedDataWithKey:(NSString *)key {
    return [self KKAES256EncryptedDataWithKey:key iv:nil];
}

- (NSData *)KKAES256DecryptedDataWithKey:(NSString *)key {
    return [self KKAES256DecryptedDataWithKey:key iv:nil];
}

- (NSData *)KKAES256EncryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv {
    return [self AES256Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)KKAES256DecryptedDataWithKey:(NSString *)key iv:(NSString * _Nullable)iv {
    return [self AES256Operation:kCCDecrypt key:key iv:iv];
}

#pragma mark - Private

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    if (iv) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)AES256Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    if (iv) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }

    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSString *)KKHexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer) {
        return [NSString string];
    }
    
    NSUInteger dataLength  = [self length];
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }
    
    return [NSString stringWithString:hexString];
}

@end
