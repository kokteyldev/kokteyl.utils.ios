//
//  UIImage+KKUtils.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KKUtils)

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size;
+ (UIImage *)cropImageToSquare:(UIImage *)originalImage
                   minEdgeVal:(int)minEdgeVal
                   maxEdgeVal:(int)maxEdgeVal;
+ (UIImage *)cropImageToSquare:(UIImage *)originalImage maxEdgeVal:(int)maxEdgeVal;
+ (BOOL)saveImageToDocuments:(UIImage *)image withName:(NSString *)imageName;
+ (UIImage*)getImageFromDocumentsWithImageName:(NSString *)imageName;
+ (BOOL)deleteImageFromDocumentsWithName:(NSString *)imageName;

//Animated Gif
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end

