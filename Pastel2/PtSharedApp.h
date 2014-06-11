//
//  PtSharedApp.h
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LUKeychainAccess.h"

typedef NS_ENUM(NSInteger, PtSharedAppThemeColor){
    PtSharedAppThemeColorDefault = 1,
    PtSharedAppThemeColorRed
};

@interface PtSharedApp : NSObject

@property (nonatomic, assign) BOOL didUnlockBonusFilterPack;
@property (nonatomic, assign) BOOL didBuyFiltersPack1;
@property (nonatomic, assign) BOOL startInCameraMode;
@property (nonatomic, assign) BOOL shootAndShare;
@property (nonatomic, assign) BOOL useDefaultCameraApp;
@property (nonatomic, assign) BOOL useFullResolutionImage;
@property (nonatomic, assign) PtSharedAppThemeColor themeColor;

@property (nonatomic, strong) UIImage* imageToProcess;
@property (nonatomic, assign) CGSize sizeOfImageToProcess;
@property (nonatomic, assign) BOOL lastEditingPhotoExists;

+ (PtSharedApp*)instance;
+ (float)bottomNavigationBarHeight;
+ (UIColor*)bottomNavigationBarBgColor;

+ (void)saveOriginalImageToFile:(UIImage*)image;
+ (void)saveOriginalImageDataToFile:(NSData*)data;
+ (UIImage*)loadOriginalImageFromFile;
+ (NSURL*)originalImageUrl;

@end
