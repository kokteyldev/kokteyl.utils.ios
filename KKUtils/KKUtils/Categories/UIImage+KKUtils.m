//
//  UIImage+KKUtils.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "UIImage+KKUtils.h"
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

@implementation UIImage (KKUtils)

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);

    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRect:rect] addClip];
    // Draw your image
    [image drawInRect:rect];

    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();

    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage*)cropImageToSquare:(UIImage*)originalImage
                   minEdgeVal:(int)minEdgeVal
                   maxEdgeVal:(int)maxEdgeVal {

    if (originalImage.size.width <= maxEdgeVal &&
        originalImage.size.height <= maxEdgeVal &&
        originalImage.size.width >= minEdgeVal &&
        originalImage.size.height >= minEdgeVal &&
        originalImage.size.width == originalImage.size.height
        )
        return originalImage;

    CGFloat scaleFactor;

    if (originalImage.size.width < originalImage.size.height) {
        scaleFactor = maxEdgeVal/originalImage.size.width;
    } else {
        scaleFactor = maxEdgeVal/originalImage.size.height;
    }

    UIImage* croppedImage;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(maxEdgeVal, maxEdgeVal), YES, 0);

    if (originalImage.size.width > originalImage.size.height) {
        [originalImage drawInRect:CGRectMake(-(originalImage.size.width*scaleFactor-maxEdgeVal)/2, 0, originalImage.size.width*scaleFactor, originalImage.size.height*scaleFactor)];
    } else {
        [originalImage drawInRect:CGRectMake(0, -(originalImage.size.height*scaleFactor-maxEdgeVal)/2, originalImage.size.width*scaleFactor, originalImage.size.height*scaleFactor)];
    }
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return croppedImage;
}


+ (UIImage*)cropImageToSquare:(UIImage*)originalImage maxEdgeVal:(int)maxEdgeVal {

    if ((originalImage.size.width == originalImage.size.height ||
         originalImage.size.width == 0 ||
         originalImage.size.height == 0) &&
        originalImage.size.width <= maxEdgeVal && originalImage.size.height <= maxEdgeVal
        )
        return originalImage;

    CGFloat scaleFactor;

    if (originalImage.size.width < originalImage.size.height) {
        scaleFactor = maxEdgeVal/originalImage.size.width;
    } else {
        scaleFactor = maxEdgeVal/originalImage.size.height;
    }

    UIImage* croppedImage;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(maxEdgeVal, maxEdgeVal), YES, 0);

    if (originalImage.size.width > originalImage.size.height) {
        [originalImage drawInRect:CGRectMake(-(originalImage.size.width*scaleFactor-maxEdgeVal)/2, 0, originalImage.size.width*scaleFactor, originalImage.size.height*scaleFactor)];
    } else {
        [originalImage drawInRect:CGRectMake(0, -(originalImage.size.height*scaleFactor-maxEdgeVal)/2, originalImage.size.width*scaleFactor, originalImage.size.height*scaleFactor)];
    }
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return croppedImage;
}


+ (BOOL)saveImageToDocuments:(UIImage*)image withName:(NSString*)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSData *imageData = UIImagePNGRepresentation(image);
    return ([imageData writeToFile:savedImagePath atomically:NO]);
}

+ (UIImage*)getImageFromDocumentsWithImageName:(NSString*)imageName {
    UIImage *returnImg = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    returnImg = [UIImage imageWithContentsOfFile:getImagePath];
    return returnImg;
}

+ (BOOL)deleteImageFromDocumentsWithName:(NSString*)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:&error];
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

//Animated Gif

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

@end
