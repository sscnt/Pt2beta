//
//  VnEffect.m
//  Pastel2
//
//  Created by SSC on 2014/05/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffect.h"

@implementation VnEffect

- (id)init
{
    self = [super init];
    if (self) {
        _defaultOpacity = 1.0f;
        _faceOpacity = 1.0f;
    }
    return self;
}

+ (UIImage*)processImage:(UIImage *)image WithStartFilter:(VnImageFilter *)startFilter EndFilter:(VnImageFilter *)endFilter
{
    @autoreleasepool {
        GPUImagePicture* pic = [[GPUImagePicture alloc] initWithImage:image];
        [pic addTarget:startFilter];
        [pic processImage];
        image = [endFilter imageFromCurrentlyProcessedOutputWithOrientation:UIImageOrientationUp];
    }
    return image;
}
/*
- (void)dealloc
{
    self.startFilter = nil;
    self.endFilter = nil;
}
 
 */

@end
