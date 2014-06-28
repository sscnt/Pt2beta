//
//  PtUtilImage.m
//  Pastel2
//
//  Created by SSC on 2014/06/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtUtilImage.h"

static size_t align16(size_t size)
{
    if(size == 0)
        return 0;
    
    return (((size - 1) >> 4) << 4) + 16;
}

@implementation PtUtilImage

static PtUtilImage* sharedPtUtilImage = nil;

+ (PtUtilImage*)instance {
	@synchronized(self) {
		if (sharedPtUtilImage == nil) {
			sharedPtUtilImage = [[self alloc] init];
		}
	}
	return sharedPtUtilImage;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPtUtilImage == nil) {
			sharedPtUtilImage = [super allocWithZone:zone];
			return sharedPtUtilImage;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark gradient

+ (CGPoint)multiplierAtIndex:(int)index
{
    NSMutableArray* arr = [self instance].lastSplittedImageMultipliers;
    if (arr.count <= index) {
        return CGPointMake(0.0f, 0.0f);
    }
    NSValue* val = [arr objectAtIndex:index];
    return [val CGPointValue];
}

+ (CGPoint)addingAtIndex:(int)index
{
    NSMutableArray* arr = [self instance].lastSplittedImageAddings;
    if (arr.count <= index) {
        return CGPointMake(0.0f, 0.0f);
    }
    NSValue* val = [arr objectAtIndex:index];
    return [val CGPointValue];
}

#pragma mark util

+ (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);        //      バッファをロック
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);      //      バッファをアンロック
    return newImage;
}


#pragma mark 25

+ (NSMutableArray*)splitImageIn25Parts:(UIImage *)image
{
    PtUtilImage* util = [self instance];
    if (util.lastSplittedImageMultipliers) {
        [util.lastSplittedImageMultipliers removeAllObjects];
    }
    util.lastSplittedImageMultipliers = [NSMutableArray array];
    
    if (util.lastSplittedImageAddings) {
        [util.lastSplittedImageAddings removeAllObjects];
    }
    util.lastSplittedImageAddings = [NSMutableArray array];
    
    float cropWidth = floor(image.size.width / 5.0f);
    float cropHeight = floor(image.size.height / 5.0f);
    float padding = 20.0f;
    
    float width1 = cropWidth;
    float width2 = cropWidth;
    float width3 = cropWidth;
    float width4 = cropWidth;
    float width5 = image.size.width - width1 - width2 - width3 - width4;
    float height1 = cropHeight;
    float height2 = cropHeight;
    float height3 = cropHeight;
    float height4 = cropHeight;
    float height5 = image.size.height - height1 - height2 - height3 - height4;
    
    float mx1 = (width1 + padding) / image.size.width;
    float mx2 = (width2 + padding * 2.0f) / image.size.width;
    float mx3 = (width3 + padding * 2.0f) / image.size.width;
    float mx4 = (width4 + padding * 2.0f) / image.size.width;
    float mx5 = (width5 + padding) / image.size.width;
    float mh1 = (height1 + padding) / image.size.height;
    float mh2 = (height2 + padding * 2.0f) / image.size.height;
    float mh3 = (height3 + padding * 2.0f) / image.size.height;
    float mh4 = (height4 + padding * 2.0f) / image.size.height;
    float mh5 = (height5 + padding) / image.size.height;
    
    //// Multiplier
    NSMutableArray* arr = util.lastSplittedImageMultipliers;
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx1, mh1)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx2, mh1)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx3, mh1)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx4, mh1)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx5, mh1)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx1, mh2)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx2, mh2)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx3, mh2)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx4, mh2)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx5, mh2)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx1, mh3)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx2, mh3)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx3, mh3)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx4, mh3)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx5, mh3)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx1, mh4)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx2, mh4)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx3, mh4)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx4, mh4)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx5, mh4)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx1, mh5)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx2, mh5)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx3, mh5)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx4, mh5)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(mx5, mh5)]];
    
    //// adder
    arr = util.lastSplittedImageAddings;
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 - padding) / image.size.width, 0.0f)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 - padding) / image.size.width, 0.0f)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 - padding) / image.size.width, 0.0f)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 + width4 - padding) / image.size.width, 0.0f)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(0.0f, (height1 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 - padding) / image.size.width, (height1 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 - padding) / image.size.width, (height1 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 - padding) / image.size.width, (height1 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 + width4 - padding) / image.size.width, (height1 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(0.0f, (height1 + height2 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 - padding) / image.size.width, (height1 + height2 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 - padding) / image.size.width, (height1 + height2 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 - padding) / image.size.width, (height1 + height2 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 + width4 - padding) / image.size.width, (height1 + height2 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(0.0f, (height1 + height2 + height3 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 - padding) / image.size.width, (height1 + height2 + height3 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 - padding) / image.size.width, (height1 + height2 + height3 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 - padding) / image.size.width, (height1 + height2 + height3 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 + width4 - padding) / image.size.width, (height1 + height2 + height3 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake(0.0f, (height1 + height2 + height3 + height4 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 - padding) / image.size.width, (height1 + height2 + height3 + height4 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 - padding) / image.size.width, (height1 + height2 + height3 + height4 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 - padding) / image.size.width, (height1 + height2 + height3 + height4 - padding) / image.size.height)]];
    [arr addObject:[NSValue valueWithCGPoint:CGPointMake((width1 + width2 + width3 + width4 - padding) / image.size.width, (height1 + height2 + height3 + height4 - padding) / image.size.height)]];
    
    
    NSMutableArray* array = [NSMutableArray array];
    
    //// 1
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, 0.0f, width1 + padding, height1 + padding)];
        [array addObject:piece];
    }
    //// 2
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 - padding, 0.0f, width2 + padding * 2.0f, height1 + padding)];
        [array addObject:piece];
    }
    //// 3
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 - padding, 0.0f, width3 + padding * 2.0f, height1 + padding)];
        [array addObject:piece];
    }
    //// 4
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 - padding, 0.0f, width4 + padding * 2.0f, height1 + padding)];
        [array addObject:piece];
    }
    //// 5
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 + width4 - padding, 0.0f, width5 + padding, height1 + padding)];
        [array addObject:piece];
    }
    //// 6
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1 - padding, width1 + padding, height2 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 7
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 - padding, height1 - padding, width2 + padding * 2.0f, height2 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 8
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 - padding, height1 - padding, width3 + padding * 2.0f, height2 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 9
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 - padding, height1 - padding, width4 + padding * 2.0f, height2 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 10
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 + width4 - padding, height1 - padding, width5 + padding, height2 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 11
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1 + height2 - padding, width1 + padding, height3 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 12
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 - padding, height1 + height2 - padding, width2 + padding * 2.0f, height3 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 13
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 - padding, height1 + height2 - padding, width3 + padding * 2.0f, height3 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 14
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 - padding, height1 + height2 - padding, width4 + padding * 2.0f, height3 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 15
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 + width4 - padding, height1 + height2 - padding, width5 + padding, height3 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 16
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1 + height2 + height3 - padding, width1 + padding, height4 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 17
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 - padding, height1 + height2 + height3 - padding, width2 + padding * 2.0f, height4 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 18
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 - padding, height1 + height2 + height3 - padding, width3 + padding * 2.0f, height4 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 19
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 - padding, height1 + height2 + height3 - padding, width4 + padding * 2.0f, height4 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 20
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 + width4 - padding, height1 + height2 + height3 - padding, width5 + padding, height4 + padding * 2.0f)];
        [array addObject:piece];
    }
    //// 21
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(0.0f, height1 + height2 + height3 + height4 - padding, width1 + padding, height5 + padding)];
        [array addObject:piece];
    }
    //// 22
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 - padding, height1 + height2 + height3 + height4 - padding, width2 + padding * 2.0f, height5 + padding)];
        [array addObject:piece];
    }
    //// 23
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 - padding, height1 + height2 + height3 + height4 - padding, width3 + padding * 2.0f, height5 + padding)];
        [array addObject:piece];
    }
    //// 24
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 - padding, height1 + height2 + height3 + height4 - padding, width4 + padding * 2.0f, height5 + padding)];
        [array addObject:piece];
    }
    //// 25
    @autoreleasepool {
        UIImage* piece = [image croppedImage:CGRectMake(width1 + width2 + width3 + width4 - padding, height1 + height2 + height3 + height4 - padding, width5 + padding, height5 + padding)];
        [array addObject:piece];
    }
    return  array;
}



+ (NSData*)mergeSplitImage25:(NSMutableArray*)array WithSize:(CGSize)size
{
    float cropWidth = floor(size.width / 5.0f);
    float cropHeight = floor(size.height / 5.0f);
    
    float width1 = cropWidth;
    float width2 = cropWidth;
    float width3 = cropWidth;
    float width4 = cropWidth;
    float width5 = size.width - width1 - width2 - width3 - width4;
    float height1 = cropHeight;
    float height2 = cropHeight;
    float height3 = cropHeight;
    float height4 = cropHeight;
    float height5 = size.height - height1 - height2 - height3 - height4;
    float padding = 20.0f;
    
    size_t width = size.width;
    size_t height = size.height;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = align16(4 * width);
    size_t bufferSize = bytesPerRow * height;
    uint8_t *bytes = (uint8_t*)malloc(bufferSize);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(bytes, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGContextClearRect(context, CGRectMake(0, 0, width, height));
    
    //// 座標系に注意
    //// 1
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0.0f, 0.0f, image.size.width - padding, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(0.0f, height - height1, width1, height1), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 2
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, 0.0f, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1, height - height1, width2, height1), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 3
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, 0.0f, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2, height - height1, width3, height1), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 4
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, 0.0f, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3, height - height1, width4, height1), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 5
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, 0.0f, image.size.width - padding, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3 + width4, height - height1, width5, height1), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 6
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0.0f, padding, image.size.width - padding, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(0.0f, height - height1 - height2, width1, height2), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 7
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1, height - height1 - height2, width2, height2), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 8
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2, height - height1 - height2, width3, height2), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 9
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3, height - height1 - height2, width4, height2), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 10
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3 + width4, height - height1 - height2, width5, height2), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 11
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0.0f, padding, image.size.width - padding, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(0.0f, height5 + height4, width1, height3), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 12
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1, height5 + height4, width2, height3), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 13
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2, height5 + height4, width3, height3), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 14
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3, height5 + height4, width4, height3), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 15
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3 + width4, height5 + height4, width5, height3), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 16
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0.0f, padding, image.size.width - padding, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(0.0f, height5, width1, height4), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 17
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1, height5, width2, height4), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 18
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2, height5, width3, height4), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 19
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3, height5, width4, height4), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 20
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding, image.size.height - padding * 2.0f));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3 + width4, height5, width5, height4), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 21
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0.0f, padding, image.size.width - padding, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width1, height5), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 22
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1, 0.0f, width2, height5), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 23
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2, 0.0f, width3, height5), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 24
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding * 2.0f, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3, 0.0f, width4, height5), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    //// 25
    @autoreleasepool {
        UIImage* image = [array objectAtIndex:0];
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(padding, padding, image.size.width - padding, image.size.height - padding));
        CGContextDrawImage(context, CGRectMake(width1 + width2 + width3 + width4, 0.0f, width5, height5), imageRef);
        [array removeObjectAtIndex:0];
        CGImageRelease(imageRef);
    }
    
    
    [array removeAllObjects];
    
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
    NSData* data = UIImageJPEGRepresentation(mergedImage, 0.96);
    CGImageRelease(image);
    image = NULL;
    free(bytes);
    return data;
}


+ (UIImage *)zoomImage:(UIImage *)image ToScale:(float)zoom
{
    
    if (zoom != 1.0f) {
        float width = roundf(image.size.width / zoom);
        float height = roundf(image.size.height / zoom);
        float afterWidth = image.size.width;
        float afterHeight = image.size.height;
        float length = MAX(width, height);
        if (length < 1920.0f) {
            afterWidth = roundf(afterWidth / 2.0f);
            afterHeight = roundf(afterHeight / 2.0f);
        }
        float x = roundf((image.size.width - width) / 2.0f);
        float y = roundf((image.size.height - height) / 2.0f);
        @autoreleasepool {
            image = [image croppedImage:CGRectMake(x, y, width, height)];
            if (afterWidth < image.size.width) {
                image = [image resizedImage:CGSizeMake(afterWidth, afterHeight) interpolationQuality:kCGInterpolationHigh];
            }
        }
    }
    
    return image;
}


+ (UIImage*)rotateImage:(UIImage*)img angle:(int)angle
{
    CGImageRef      imgRef = [img CGImage];
    CGContextRef    context;
    
    switch (angle) {
        case 90:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.height, img.size.width), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.height, img.size.width);
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, M_PI_2);
            break;
        case 180:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.width, img.size.height), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.width, 0);
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, -M_PI);
            break;
        case 270:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.height, img.size.width), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, -M_PI_2);
            break;
        default:
            return img;
            break;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), imgRef);
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    result = [UIImage imageWithCGImage:[result CGImage] scale:result.scale orientation:UIImageOrientationUp];
    return result;
}

+ (UIImage *)fixOrientationOfImageFromCamera:(UIImage *)image {
    
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

+ (UIImage *)resizedImageUrl:(NSURL *)url ToSize:(CGSize)size
{
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

@end
