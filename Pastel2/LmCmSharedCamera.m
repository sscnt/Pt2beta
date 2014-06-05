//
//  LmCurrentCamera.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmSharedCamera.h"
#import "LmCmImageAsset.h"

@implementation LmCmSharedCamera

static LmCmSharedCamera* sharedLmCurrentCamera = nil;

+ (LmCmSharedCamera*)instance {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [[self alloc] init];
		}
	}
	return sharedLmCurrentCamera;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [super allocWithZone:zone];
			return sharedLmCurrentCamera;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

+ (void)reset
{
    [[LmCmSharedCamera instance] reset];
}

- (void)reset
{
    _mode = LmCmSharedCameraModeNormal;
    _zoom = 1.0f;
}

+ (UIImage *)cropImage:(UIImage *)image WithCropSize:(LmCmViewCropSize)cropSize
{
    
    if (cropSize == LmCmViewCropSizeNormal) {
        return image;
    }
    //image = [image resizedImage:CGSizeMake(image.size.width/ 10.0f, image.size.height/10.0f) interpolationQuality:kCGInterpolationHigh];
    float width = image.size.width, height, x = 0.0f, y;
    switch (cropSize) {
        case LmCmViewCropSize2x1:
        {
            height = width / 2.0f;
            y = (image.size.height - height) / 2.0f;
            return [image croppedImage:CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height))];
        }
            break;
        case LmCmViewCropSize16x9:
        {
            height = width * 9.0f / 16.0f;
            y = (image.size.height - height) / 2.0f;
            return [image croppedImage:CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height))];
            
        }
            break;
        case LmCmViewCropSizeSquare:
        {
            if (image.size.width > image.size.height) {
                width = image.size.height;
                height = width;
                y = 0.0f;
                x = (image.size.width - width) / 2.0f;
                return [image croppedImage:CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height))];
            }else{
                width = image.size.width;
                height = width;
                y = (image.size.height - height) / 2.0f;
                x = 0.0f;
                return [image croppedImage:CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height))];
            }
        }
            break;
    }
    
    return nil;
}


+ (LmCmImageAsset *)fixRotationWithNoSoundImageAsset:(LmCmImageAsset *)asset
{
    UIImage* image = asset.image;
    if (asset.frontCamera) {
        switch (asset.orientation) {
            case UIDeviceOrientationUnknown:
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                image = [self rotateImage:image angle:90];
                break;
            case UIDeviceOrientationPortrait:
                image = [self rotateImage:image angle:270];
                break;
            case UIDeviceOrientationLandscapeLeft:
                image = [self rotateImage:image angle:180];
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
        switch (asset.orientation) {
            case UIDeviceOrientationUnknown:
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                image = [self rotateImage:image angle:90];
                break;
            case UIDeviceOrientationPortrait:
                image = [self rotateImage:image angle:270];
                break;
            case UIDeviceOrientationLandscapeLeft:
                break;
            case UIDeviceOrientationLandscapeRight:
                image = [self rotateImage:image angle:180];
                break;
            case UIDeviceOrientationFaceUp:
                break;
            case UIDeviceOrientationFaceDown:
                break;
            default:
                break;
        }
    }
    asset.image = image;
    return asset;
}

+ (LmCmImageAsset *)applyZoomToAsset:(LmCmImageAsset *)asset
{
    UIImage* image = asset.image;
    @autoreleasepool {
        float zoom = [LmCmSharedCamera instance].zoom;
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
    }
    asset.image = image;
    return asset;
}

+ (LmCmImageAsset *)cropAsset:(LmCmImageAsset *)asset
{
    asset.image = [LmCmSharedCamera cropImage:asset.image WithCropSize:asset.cropSize];
    return asset;
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


#pragma mark settings


+ (float)topBarHeight
{
    return 50.0f;
}

+ (float)bottomBarHeight
{
    return 88.0f;
}

+ (CGRect)shutterButtonRect
{
    return CGRectMake(0.0f, 0.0f, 66.0f, 66.0f);
}

+ (UIColor *)topBarColor
{
    return [UIColor colorWithWhite:0.10f alpha:1.0f];
}

+ (UIColor *)bottomBarColor
{
    return [self topBarColor];
}

+ (UIColor *)topBarTransparentColor
{
    return [UIColor colorWithWhite:0.10f alpha:0.60f];
}

+ (UIColor *)bottomBarTransparentColor
{
    return [self topBarTransparentColor];
}

+ (UIColor *)cropMaskColor
{
    return [UIColor colorWithWhite:0.15f alpha:1.0f];
}

#pragma mark api
#pragma mark zoom

+ (void)setZoom:(float)zoom
{
    [self instance].zoom = zoom;
}

+ (float)maxZoomScaleSupported
{
    return 9.0f;
}

+ (UIColor *)zoomSliderBgColor
{
    return [UIColor colorWithWhite:0.10f alpha:0.50f];
}

#pragma mark settings

+ (UIColor *)settingsBgColor
{
    return [UIColor colorWithWhite:0.10f alpha:0.90f];
}

//// 2 is YES, 1 is NO, 0 is Nil
- (BOOL)showGrid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"showGrid"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showGrid = YES;
    return YES;
}

- (void)setShowGrid:(BOOL)showGrid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (showGrid) {
        [ud setInteger:2 forKey:@"showGrid"];
    }else{
        [ud setInteger:1 forKey:@"showGrid"];
    }
    [ud synchronize];
}

- (BOOL)showZoomSlider
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"showZoomSlider"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showZoomSlider = YES;
    return YES;
}

- (void)setShowZoomSlider:(BOOL)showZoomSlider
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (showZoomSlider) {
        [ud setInteger:2 forKey:@"showZoomSlider"];
    }else{
        [ud setInteger:1 forKey:@"showZoomSlider"];
    }
    [ud synchronize];
}

- (BOOL)soundEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"soundEnabled"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.soundEnabled = YES;
    return YES;
}

- (void)setSoundEnabled:(BOOL)soundEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (soundEnabled) {
        [ud setInteger:2 forKey:@"soundEnabled"];
    }else{
        [ud setInteger:1 forKey:@"soundEnabled"];
    }
    [ud synchronize];
}


- (BOOL)volumeSnapEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"volumeSnapEnabled"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.volumeSnapEnabled = YES;
    return YES;
}

- (void)setVolumeSnapEnabled:(BOOL)volumeSnapEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (volumeSnapEnabled) {
        [ud setInteger:2 forKey:@"volumeSnapEnabled"];
    }else{
        [ud setInteger:1 forKey:@"volumeSnapEnabled"];
    }
    [ud synchronize];
}


- (LmCmViewCropSize)cropSize
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int size = (int)[ud integerForKey:@"cropSize"];
    if (size == 0) {
        self.cropSize = LmCmViewCropSizeNormal;
        return LmCmViewCropSizeNormal;
    }
    return size;
}

- (void)setCropSize:(LmCmViewCropSize)cropSize
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:cropSize forKey:@"cropSize"];
    [ud synchronize];
}


- (LmCmViewBarButtonFlashMode)flashMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int size = (int)[ud integerForKey:@"flashMode"];
    if (size == 0) {
        self.flashMode = LmCmViewBarButtonFlashModeAuto;
        return LmCmViewBarButtonFlashModeAuto;
    }
    return size;
}

- (void)setFlashMode:(LmCmViewBarButtonFlashMode)flashMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:flashMode forKey:@"flashMode"];
    [ud synchronize];
}

- (LmCmSharedCameraFocusMode)focusMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int size = (int)[ud integerForKey:@"focusMode"];
    if (size == 0) {
        self.focusMode = LmCmSharedCameraFocusModeAuto;
        return LmCmSharedCameraFocusModeAuto;
    }
    return size;
}

- (void)setFocusMode:(LmCmSharedCameraFocusMode)focusMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:focusMode forKey:@"focusMode"];
    [ud synchronize];
}



@end
