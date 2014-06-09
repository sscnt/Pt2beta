//
//  PtSharedApp.m
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtSharedApp.h"

@implementation PtSharedApp

static PtSharedApp* sharedPtSharedApp = nil;
NSString* const pathForOriginalImage = @"tmp/original_image";

+ (PtSharedApp*)instance {
	@synchronized(self) {
		if (sharedPtSharedApp == nil) {
			sharedPtSharedApp = [[self alloc] init];
		}
	}
	return sharedPtSharedApp;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPtSharedApp == nil) {
			sharedPtSharedApp = [super allocWithZone:zone];
			return sharedPtSharedApp;
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
    }
    return self;
}

- (void)setImageToProcess:(UIImage *)imageToProcess
{
    if (imageToProcess == nil) {
        return;
    }
    _imageToProcess = imageToProcess;
    _sizeOfImageToProcess = _imageToProcess.size;
    LOG_SIZE(_sizeOfImageToProcess);
}

#pragma mark ui


+ (float)bottomNavigationBarHeight
{
    return 44.0f;
}

+ (UIColor*)bottomNavigationBarBgColor
{
    return [PtEdConfig bgColor];
}


#pragma mark settings

//// エフェクトのアンロック
- (BOOL)didUnlockExtraEffects
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL f = [ud boolForKey:@"unlocked"];
    if (f == YES) {
        return YES;
    }
    return NO;
}

- (void)setDidUnlockExtraEffects:(BOOL)didUnlockExtraEffects
{
    if (didUnlockExtraEffects) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:YES forKey:@"unlocked"];
        [ud synchronize];
    }
}


//// エフェクトの購入
- (BOOL)didBuyEffectsPack1
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL f = [ud boolForKey:@"buy_pack_1"];
    if (f == YES) {
        return YES;
    }
    return NO;
}

- (void)setDidBuyEffectsPack1:(BOOL)didBuyEffectsPack1
{
    if (didBuyEffectsPack1) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:YES forKey:@"buy_pack_1"];
        [ud synchronize];
    }
}

//// 起動時にカメラモード

- (BOOL)startInCameraMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"startInCameraMode"];
    if (f == 2) {
        return YES;
    }else if(f == 1){
        return NO;
    }
    //// デフォルト
    self.startInCameraMode = YES;
    return YES;
}

- (void)setStartInCameraMode:(BOOL)startInCameraMode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger flag = (startInCameraMode) ? 2 : 1;
    [ud setInteger:flag forKey:@"startInCameraMode"];
    [ud synchronize];
}

//// 撮影してすぐ共有

- (BOOL)shootAndShare
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"shootAndShare"];
    if (f == 2) {
        return YES;
    }else if(f == 1){
        return NO;
    }
    //// デフォルト
    self.shootAndShare = YES;
    return YES;
}

- (void)setShootAndShare:(BOOL)shootAndShare
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger flag = (shootAndShare) ? 2 : 1;
    [ud setInteger:flag forKey:@"shootAndShare"];
    [ud synchronize];
}

//// iPhoneのデフォルトのカメラを使う

- (BOOL)useDefaultCameraApp
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"useDefaultCameraApp"];
    if (f == 2) {
        return YES;
    }else if(f == 1){
        return NO;
    }
    //// デフォルト
    self.startInCameraMode = NO;
    return NO;
}

- (void)setUseDefaultCameraApp:(BOOL)useDefaultCameraApp
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger flag = (useDefaultCameraApp) ? 2 : 1;
    [ud setInteger:flag forKey:@"useDefaultCameraApp"];
    [ud synchronize];
}

//// 最大解像度

- (BOOL)useFullResolutionImage
{
    LOG(@"MUST DELETE LINE");
    return YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"useFullResolutionImage"];
    if (f == 2) {
        return YES;
    }else if(f == 1){
        return NO;
    }
    //// デフォルト
    self.useFullResolutionImage = NO;
    return NO;
}

- (void)setUseFullResolutionImage:(BOOL)useFullResolutionImage
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger flag = (useFullResolutionImage) ? 2 : 1;
    [ud setInteger:flag forKey:@"useFullResolutionImage"];
    [ud synchronize];
}

//// テーマカラー

- (PtSharedAppThemeColor)themeColor
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"themeColor"];
    if (f != 0) {
        return (PtSharedAppThemeColor)f;
    }
    //// デフォルト
    self.themeColor = PtSharedAppThemeColorDefault;
    return PtSharedAppThemeColorDefault;
}

- (void)setThemeColor:(PtSharedAppThemeColor)themeColor
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:(int)themeColor forKey:@"themeColor"];
    [ud synchronize];
}

//// 画像

- (BOOL)lastEditingPhotoExists
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        return YES;
    }
    return NO;
}

+ (void)saveOriginalImageToFile:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99);
    [self saveOriginalImageDataToFile:imageData];
}

+ (void)saveOriginalImageDataToFile:(NSData *)data
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    BOOL success = [data writeToFile:filePath atomically:YES];
}

+ (UIImage *)loadOriginalImageFromFile
{
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:fileURL]];
        return img;
    }
    return nil;
}

+ (NSURL *)originalImageUrl
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    return fileURL;
}



@end
