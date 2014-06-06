//
//  CameraManager.h
//  CameraTemplate
//
//  Created by Takashi Otsuka on 2013/06/16.
//  Copyright (c) 2013年 takatronix.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMBufferQueue.h>
#import "LmCmImageAsset.h"


////////////////////////////////
//      必要なlibrary
////////////////////////////////
//      AVFoundation
//      CoreVideo
//      CoreMedia


////////////////////////////////////////////////
//      カメラマネージャデリゲート
////////////////////////////////////////////////
@class LmCmCamera;
@protocol LmCmCameraDelegate <NSObject>
@optional
-(void)videoFrameUpdate:(CGImageRef)cgImage from:(LmCmCamera*)manager;
- (void)singleImageNoSoundDidTakeWithAsset:(LmCmImageAsset*)lmAsset;
- (void)singleImageByNormalCameraDidTakeWithAsset:(LmCmImageAsset*)lmAsset;
- (void)shootingDidCancel;
@end


@interface LmCmCamera : NSObject <AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>


-(id)init;
-(id)initWithPreset:(NSString*)preset;

@property(nonatomic, weak) UIViewController<LmCmCameraDelegate>* delegate;

@property (nonatomic, assign) BOOL processingToConvert;
@property (nonatomic, assign) int currentCapturedNumber;
@property (nonatomic, assign) int allCaptureNumber;
@property (nonatomic, assign) BOOL isRunning;

- (void)takeOnePicture;
- (void)takeOnePicutreWithNoSound;
- (void)takeOnePicutreByNormalCamera;

- (void)enableCamera;
- (void)disableCamera;
- (void)deallocCamera;

- (NSString*)presetString;

@property AVCaptureVideoPreviewLayer*     previewLayer;         // プレビューレイヤ
-(void)setPreview:(UIView*)view;                                // プレビューを表示するビューを設定する


/////////////////////////////////////////////////////////
//    フラッシュライト制御　バックカメラ時のみ有効
//    フロントカメラ時、ONにするとバックカメラに自動で切り替えます
/////////////////////////////////////////////////////////
-(void)light:(BOOL)yesno;                                       // ライト ON/OFF
-(void)lightToggle;                                             // ライト ON/OFF切り替え
-(BOOL)isLightOn;                                               // 現在ライトがついているか

- (void)flash:(BOOL)enabled;
- (void)autoFlash:(BOOL)enabled;

/////////////////////////////////////////////////////////
//      カメラ制御
/////////////////////////////////////////////////////////
-(void)useFrontCamera:(BOOL)yesno;                                 //   フロントカメラを有効にする
-(void)flipCamera;                                                 //   フロントカメラ・バックカメラを切り替える
-(BOOL)isUsingFrontCamera;                                         // 　フロントカメラを使っているか(ミラー表示中)
//      所有しているカメラデバイスの名称や詳細などを取得できます
@property AVCaptureDevice* backCameraDevice;        //   バックカメラデバイス
@property AVCaptureDevice* frontCameraDevice;       //   フロントカメラデバイス

/////////////////////////////////////////////////////////
//      フォーカス制御
/////////////////////////////////////////////////////////
- (void) autoFocusAtPoint:(CGPoint)point;
- (void) continuousFocusAtPoint:(CGPoint)point;

/////////////////////////////////////////////////////////
//   カメラ撮影(シャッター音あり)
//   向きを考慮した静止画を取得(Blockで結果を得る)
/////////////////////////////////////////////////////////
typedef void (^takePhotoBlock)(UIImage *image, NSError *error);
- (void)takePhoto:(takePhotoBlock) block;


@end
