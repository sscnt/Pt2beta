//
//  UIImage+extend.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIImage+extend.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (extend)

- (UIImage *)croppedImage:(CGRect)bounds {
    CGFloat scale = MAX(self.scale, 1.0f);
    CGRect scaledBounds = CGRectMake(bounds.origin.x * scale, bounds.origin.y * scale, bounds.size.width * scale, bounds.size.height * scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledBounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)


// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    switch ( self.imageOrientation )
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
        default:
            drawTransposed = NO;
    }
    
    newSize = CGSizeMake(newSize.width, newSize.height);
    
    CGAffineTransform transform = [self transformForOrientation:newSize];
    
    return [self resizedImage:newSize transform:transform drawTransposed:drawTransposed interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark resizing

- (UIImage *)resizeImageAndConvertJpeg:(CGSize)size
{
    
    size_t width = size.width;
    size_t height = size.height;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = 4 * width;
    size_t bytesSize = bytesPerRow * height;
    uint8_t *bytes = malloc(bytesSize);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault;
    
    CGContextRef context = CGBitmapContextCreate(bytes, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    
    CGContextRelease(context);
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, bytes, bytesSize, bufferFree);
    size_t bitsPerPixel = 32;
    CGImageRef rasterImage = CGImageCreate(width,
                                           height,
                                           bitsPerComponent,
                                           bitsPerPixel,
                                           bytesPerRow,
                                           colorSpace,
                                           kCGBitmapAlphaInfoMask | kCGImageAlphaPremultipliedFirst,
                                           dataProvider,
                                           NULL,
                                           NO,
                                           kCGRenderingIntentDefault);
    NSData* data = UIImageJPEGRepresentation([UIImage imageWithCGImage:rasterImage], 0.99);
    UIImage* resultImage = [UIImage imageWithData:data];
    CGDataProviderRelease(dataProvider);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(rasterImage);
    free(bytes);
    return resultImage;
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality
{
    CGFloat scale = MAX(1.0f, self.scale);
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width*scale, newSize.height*scale));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Fix for a colorspace / transparency issue that affects some types of
    // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                8, /* bits per channel */
                                                (newRect.size.width * 4), /* 4 channels per pixel * numPixels/row */
                                                colorSpace,
                                                kCGImageAlphaPremultipliedLast
                                                );
    CGColorSpaceRelease(colorSpace);
	
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:UIImageOrientationUp];
    NSData* data = UIImageJPEGRepresentation(newImage, 0.99f);
    UIImage* resultImage = [UIImage imageWithData:data];
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return resultImage;
}

#pragma mark low memory

+ (UIImage *)resizedImageUrl:(NSURL *)url ToScale:(float)scale
{
    NSLog(@"%@", url);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
    if (!imageSource)
        return nil;
    
    CFDictionaryRef options = (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:
                                                (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailWithTransform,
                                                (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailFromImageIfAbsent,
                                                (id)[NSNumber numberWithFloat:scale], (id)kCGImageSourceThumbnailMaxPixelSize,
                                                nil];
    CGImageRef imgRef = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options);
    
    UIImage* scaled = [UIImage imageWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    CFRelease(imageSource);
    
    return scaled;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

- (float)maxLength
{
    return MAX(self.size.width, self.size.height);
}
- (float)minsLength
{
    return MIN(self.size.width, self.size.height);
}

+ (UIImage *)resizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    [image drawInRect:CGRectMake(0.0, 0.0, width, height)];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

+ (UIImage *)resizedImageUrl:(NSURL *)url ToSize:(CGSize)size
{
    NSLog(@"%@", url);
    int maxPixel = (size.width > size.height) ? size.width : size.height;
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
    if (!imageSource)
        return nil;
    
    CFDictionaryRef   myOptions = NULL;
    CFStringRef       myKeys[4];
    CFTypeRef         myValues[4];
    CFNumberRef       thumbnailSize;
    
    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &maxPixel);
    
    // Set up the thumbnail options.
    myKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
    myValues[0] = (CFTypeRef)kCFBooleanTrue;
    myKeys[1] = kCGImageSourceCreateThumbnailFromImageAlways;
    myValues[1] = (CFTypeRef)kCFBooleanTrue;
    myKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
    myValues[2] = (CFTypeRef)thumbnailSize;
    
    
    
    CFDictionaryRef options = (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:
                                                         (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailWithTransform,
                                                         (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailFromImageIfAbsent,
                                                         (id)[NSNumber numberWithFloat:maxPixel], (id)kCGImageSourceThumbnailMaxPixelSize,
                                                         nil];
    
    myOptions = CFDictionaryCreate(NULL, (const void **) myKeys,
                                   (const void **) myValues, 3,
                                   &kCFTypeDictionaryKeyCallBacks,
                                   & kCFTypeDictionaryValueCallBacks);
    
    CGImageRef imgRef = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, myOptions);
    
    UIImage* scaled = [UIImage imageWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    CFRelease(imageSource);
    CFRelease(thumbnailSize);
    CFRelease(myOptions);
    
    
    return scaled;
}

+ (UIImage*)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray* images = [NSMutableArray array];
    
    NSTimeInterval duration = 0.0f;
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        NSDictionary* frameProperties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, i, NULL));
        duration += [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
        
        [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
        
        CGImageRelease(image);
    }
    
    CFRelease(source);
    
    if (!duration) {
        duration = (1.0f/10.0f)*count;
    }
    
    return [UIImage animatedImageWithImages:images duration:duration];
}

+ (UIImage*)animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString* retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

- (UIImage*)animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
	CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor :heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    } else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray* scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    for (UIImage* image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
    }
    
    UIGraphicsEndImageContext();
	
	return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}
+ (UIImage *)fixOrientationOfImage:(UIImage *)image {
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (NSMutableArray*)splitImageIn4Parts:(UIImage *)image
{
    float padding = 0.0f;
    float cropWidth = floor(image.size.width / 2.0f);
    float cropHeight = floor(image.size.height / 2.0f);
    float restWidth = image.size.width - (cropWidth - padding);
    float restHeight = image.size.height - (cropHeight - padding);
    
    NSMutableArray* array = [NSMutableArray array];
    
    //// 1
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, 0.0f, cropWidth + padding, cropHeight + padding)];
        [array addObject:piece];
    }
    //// 2
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(cropWidth - padding, 0.0f, restWidth, cropHeight + padding)];
        [array addObject:piece];
    }
    //// 3
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, cropHeight - padding, cropWidth + padding, restHeight)];
        [array addObject:piece];
    }
    //// 4
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(cropWidth - padding, cropHeight - padding, restWidth, restHeight)];
        UIImageOrientation o = piece.imageOrientation;
        [array addObject:piece];
    }
    return  array;
}

+ (UIImage *)mergeSplitImage4:(NSMutableArray*)array WithSize:(CGSize)size
{
    float padding = 0.0f;
    float cropWidth = floor(size.width / 2.0f);
    float cropHeight = floor(size.height / 2.0f);
    float restCropWidth = size.width - (cropWidth - padding);
    float restCropHeight = size.height - (cropHeight - padding);
    float restWidth = size.width - cropWidth;
    float restHeight = size.height - cropHeight;
    
    UIGraphicsBeginImageContext(size);
    
    UIImageOrientation o = ((UIImage*)[array objectAtIndex:0]).imageOrientation;
    
    //// 1
    {
        [[array objectAtIndex:0] drawAtPoint:CGPointMake(0.0f, 0.0f)];
    }
    //// 2
    {
        [[array objectAtIndex:1] drawAtPoint:CGPointMake(cropWidth, 0.0f)];
    }
    //// 3
    {
        [[array objectAtIndex:2] drawAtPoint:CGPointMake(0.0f, cropHeight)];
    }
    //// 4
    {
        [[array objectAtIndex:3] drawAtPoint:CGPointMake(cropWidth, cropHeight)];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSMutableArray*)splitImageIn9Parts:(UIImage *)image
{
    float cropWidth = floor(image.size.width / 3.0f);
    float cropHeight = floor(image.size.height / 3.0f);
    
    float width1 = cropWidth;
    float width2 = cropWidth;
    float width3 = image.size.width - width1 - width2;
    float height1 = cropHeight;
    float height2 = cropHeight;
    float height3 = image.size.height - height1 - height2;
    
    NSMutableArray* array = [NSMutableArray array];
    
    //// 1
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, 0.0f, width1, height1)];
        [array addObject:piece];
    }
    //// 2
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1, 0.0f, width2, height1)];
        [array addObject:piece];
    }
    //// 3
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2, 0.0f, width3, height1)];
        [array addObject:piece];
    }
    //// 4
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1, width1, height2)];
        [array addObject:piece];
    }
    //// 5
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1, height1, width2, height2)];
        [array addObject:piece];
    }
    //// 6
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2, height1, width3, height2)];
        [array addObject:piece];
    }
    //// 7
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1 + height2, width1, height3)];
        [array addObject:piece];
    }
    //// 8
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1, height1 + height2, width2, height3)];
        [array addObject:piece];
    }
    //// 9
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2, height1 + height2, width3, height3)];
        [array addObject:piece];
    }
    
    return  array;
}

static void bufferFree(void *info, const void *data, size_t size)
{
    free((void *)data);
}
static size_t align16(size_t size)
{
    if(size == 0)
        return 0;
    
    return (((size - 1) >> 4) << 4) + 16;
}

+ (UIImage *)mergeSplitImage9:(NSMutableArray*)array WithSize:(CGSize)size
{
    
    float cropWidth = floor(size.width / 3.0f);
    float cropHeight = floor(size.height / 3.0f);
    
    float width1 = cropWidth;
    float width2 = cropWidth;
    float width3 = size.width - width1 - width2;
    float height1 = cropHeight;
    float height2 = cropHeight;
    float height3 = size.height - height1 - height2;
    
    size_t width = size.width;
    size_t height = size.height;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = align16(4 * width);
    size_t bufferSize = bytesPerRow * height;
    uint8_t *bytes = malloc(bufferSize);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(bytes, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGContextClearRect(context, CGRectMake(0, 0, width, height));
    
    //// 座標系に注意
    //// 1
    {
        UIImage* image = [array objectAtIndex:0];
        CGContextDrawImage(context, CGRectMake(0.0f, height - image.size.height, image.size.width, image.size.height), image.CGImage);
    }
    //// 2
    {
        UIImage* image = [array objectAtIndex:1];
        CGContextDrawImage(context, CGRectMake(width1, height - image.size.height, image.size.width, image.size.height), image.CGImage);
    }
    //// 3
    {
        UIImage* image = [array objectAtIndex:2];
        CGContextDrawImage(context, CGRectMake(width1 + width2, height - image.size.height, image.size.width, image.size.height), image.CGImage);
    }
    //// 4
    {
        UIImage* image = [array objectAtIndex:3];
        CGContextDrawImage(context, CGRectMake(0.0f, height3, image.size.width, image.size.height), image.CGImage);
    }
    //// 5
    {
        UIImage* image = [array objectAtIndex:4];
        CGContextDrawImage(context, CGRectMake(width1, height3, image.size.width, image.size.height), image.CGImage);
    }
    //// 6
    {
        UIImage* image = [array objectAtIndex:5];
        CGContextDrawImage(context, CGRectMake(width1 + width2, height3, image.size.width, image.size.height), image.CGImage);
    }
    //// 7
    {
        UIImage* image = [array objectAtIndex:6];
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
    }
    //// 8
    {
        UIImage* image = [array objectAtIndex:7];
        CGContextDrawImage(context, CGRectMake(width1, 0.0f, image.size.width, image.size.height), image.CGImage);
    }
    //// 9
    {
        UIImage* image = [array objectAtIndex:8];
        CGContextDrawImage(context, CGRectMake(width1 + width2, 0.0f, image.size.width, image.size.height), image.CGImage);
    }
    
    CGContextRelease(context);
    context = NULL;
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, bytes, bufferSize, NULL);
    size_t bitsPerPixel = 32;
    CGImageRef image = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    dataProvider = NULL;
    CGColorSpaceRelease(colorSpace);
    colorSpace = NULL;
    UIImage* mergedImage = [UIImage imageWithCGImage:image scale:1.0f orientation:UIImageOrientationUp];
    NSData* data = UIImageJPEGRepresentation(mergedImage, 0.99);
    UIImage* resultImage = [UIImage imageWithData:data];
    CGImageRelease(image);
    free(bytes);
    return resultImage;
}

+ (UIImage *)_mergeSplitImage9:(NSMutableArray*)array WithSize:(CGSize)size
{
    
    float cropWidth = floor(size.width / 3.0f);
    float cropHeight = floor(size.height / 3.0f);
    
    float width1 = cropWidth;
    float width2 = cropWidth;
    float width3 = size.width - width1 - width2;
    float height1 = cropHeight;
    float height2 = cropHeight;
    float height3 = size.height - height1 - height2;
    
    
    UIGraphicsBeginImageContext(size);
    
    UIImageOrientation o = ((UIImage*)[array objectAtIndex:0]).imageOrientation;
    
    //// 1
    {
        [[array objectAtIndex:0] drawAtPoint:CGPointMake(0.0f, 0.0f)];
    }
    //// 2
    {
        [[array objectAtIndex:1] drawAtPoint:CGPointMake(width1, 0.0f)];
    }
    //// 3
    {
        [[array objectAtIndex:2] drawAtPoint:CGPointMake(width1 + width2, 0.0f)];
    }
    //// 4
    {
        [[array objectAtIndex:3] drawAtPoint:CGPointMake(0.0f, height1)];
    }
    //// 5
    {
        [[array objectAtIndex:4] drawAtPoint:CGPointMake(width1, height1)];
    }
    //// 6
    {
        [[array objectAtIndex:5] drawAtPoint:CGPointMake(width1 + width2, height1)];
    }
    //// 7
    {
        [[array objectAtIndex:6] drawAtPoint:CGPointMake(0.0f, height1 + height2)];
    }
    //// 8
    {
        [[array objectAtIndex:7] drawAtPoint:CGPointMake(width1, height1 + height2)];
    }
    //// 9
    {
        [[array objectAtIndex:8] drawAtPoint:CGPointMake(width1 + width2, height1 + height2)];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
