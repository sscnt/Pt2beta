//
//  LmCmImageAsset.m
//  Lumina
//
//  Created by SSC on 2014/05/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmImageAsset.h"

@implementation LmCmImageAsset

- (void)fixRotationToNoSoundImage
{
    UIImage* image = self.image;
    if (self.frontCamera) {
        switch (self.orientation) {
            case UIDeviceOrientationUnknown:
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                image = [PtUtilImage rotateImage:image angle:90];
                break;
            case UIDeviceOrientationPortrait:
                image = [PtUtilImage rotateImage:image angle:270];
                break;
            case UIDeviceOrientationLandscapeLeft:
                image = [PtUtilImage rotateImage:image angle:180];
                break;
            case UIDeviceOrientationLandscapeRight:
                break;
            case UIDeviceOrientationFaceUp:
                break;
            case UIDeviceOrientationFaceDown:
                break;
            default:
                break;
        }
    }else{
        switch (self.orientation) {
            case UIDeviceOrientationUnknown:
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                image = [PtUtilImage rotateImage:image angle:90];
                break;
            case UIDeviceOrientationPortrait:
                image = [PtUtilImage rotateImage:image angle:270];
                break;
            case UIDeviceOrientationLandscapeLeft:
                break;
            case UIDeviceOrientationLandscapeRight:
                image = [PtUtilImage rotateImage:image angle:180];
                break;
            case UIDeviceOrientationFaceUp:
                break;
            case UIDeviceOrientationFaceDown:
                break;
            default:
                break;
        }
    }
    self.image = image;
}

- (void)applyZoom
{
    @autoreleasepool {
        self.image = [PtUtilImage zoomImage:self.image ToScale:self.zoom];
    }
}

- (void)crop
{
    self.image = [LmCmSharedCamera cropImage:self.image WithCropSize:self.cropSize];
}


@end
