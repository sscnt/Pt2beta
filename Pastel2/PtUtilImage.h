//
//  PtUtilImage.h
//  Pastel2
//
//  Created by SSC on 2014/06/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@interface PtUtilImage : NSObject

+ (CGImageRef)imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;

+ (NSMutableArray*)splitImageIn9Parts:(UIImage *)image;
+ (UIImage *)mergeSplitImage9:(NSMutableArray*)array WithSize:(CGSize)size;
+ (UIImage*)zoomImage:(UIImage*)image ToScale:(float)zoom;
+ (UIImage*)rotateImage:(UIImage*)img angle:(int)angle;
+ (UIImage*)fixOrientationOfImageFromCamera:(UIImage *)image;
+ (UIImage*)resizedImageUrl:(NSURL*)url ToSize:(CGSize)size;

@end
