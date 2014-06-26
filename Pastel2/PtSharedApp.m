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

NSString* const pathForOriginalImage = @"tmp/original_image.jpg";

NSString* const keyChainKeyBonusFilterPack = @"jp.shelbyapps.pastel2.keychain.pack.bonus.1";
NSString* const keyChainKeyPremiumFilterPack1 = @"jp.shelbyapps.pastel2.keychain.pack.premium.1";

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
    _originalImageSize = _imageToProcess.size;
    LOG_SIZE(_originalImageSize);
}

- (void)setOriginalImageSize:(CGSize)originalImageSize
{
    _originalImageSize = originalImageSize;
    _maxPixelSizeOfOriginalImage = (originalImageSize.width > originalImageSize.height) ? originalImageSize.width : originalImageSize.height;
}

#pragma mark ui


+ (float)bottomNavigationBarHeight
{
    return 44.0f;
}

+ (UIColor*)bottomNavigationBarBgColor
{
    return [UIColor blackColor];
}


#pragma mark settings

//// ボーナスフィルターパック
- (BOOL)didUnlockBonusFilterPack
{
    LUKeychainAccess* kc = [LUKeychainAccess standardKeychainAccess];
    BOOL f = [kc boolForKey:keyChainKeyBonusFilterPack];
    if (f == YES) {
        return YES;
    }
    return NO;
}

- (void)setDidUnlockBonusFilterPack:(BOOL)didUnlockExtraEffects
{
    LUKeychainAccess* kc = [LUKeychainAccess standardKeychainAccess];
    [kc setBool:YES forKey:keyChainKeyBonusFilterPack];
}

//// プレミアムフィルターパック1
- (BOOL)didBuyFiltersPack1
{
    LUKeychainAccess* kc = [LUKeychainAccess standardKeychainAccess];
    BOOL f = [kc boolForKey:keyChainKeyPremiumFilterPack1];
    if (f == YES) {
        return YES;
    }
    return NO;
}

- (void)setDidBuyFiltersPack1:(BOOL)didBuyFiltersPack1
{
    LUKeychainAccess* kc = [LUKeychainAccess standardKeychainAccess];
    [kc setBool:YES forKey:keyChainKeyPremiumFilterPack1];
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

//// 左利き

- (BOOL)leftHandedUI
{
    LOG(@"MUST DELETE LINE");
    return YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger f = [ud integerForKey:@"leftHandedUI"];
    if (f == 2) {
        return YES;
    }else if(f == 1){
        return NO;
    }
    //// デフォルト
    self.leftHandedUI = NO;
    return NO;
}

- (void)setLeftHandedUI:(BOOL)leftHandedUI
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger flag = (leftHandedUI) ? 2 : 1;
    [ud setInteger:flag forKey:@"leftHandedUI"];
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
