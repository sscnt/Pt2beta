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
@class LmCmCameraManager;
@protocol CameraManagerDelegate <NSObject>
@optional
-(void)videoFrameUpdate:(CGImageRef)cgImage from:(LmCmCameraManager*)manager;
- (void)singleImageNoSoundDidTakeWithAsset:(LmCmImageAsset*)lmAsset;
- (void)singleImageByNormalCameraDidTakeWithAsset:(LmCmImageAsset*)lmAsset;
- (void)shootingDidCancel;
@end

//////////////////////////////////////////////////
//      カメラマネージャクラス
//////////////////////////////////////////////////
@interface LmCmCameraManager : NSObject <AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>


/*///////////////////////////////////////////
            初期化
 presetに以下の値を設定して初期化（デフォルトは640x480)
AVCaptureSessionPresetLow
AVCaptureSessionPresetHigh
AVCaptureSessionPresetMedium
AVCaptureSessionPresetPhoto
AVCaptureSessionPreset352x288
AVCaptureSessionPreset640x480
AVCaptureSessionPreset1920x1080
AVCaptureSessionPresetiFrame960x540 
AVCaptureSessionPresetiFrame1280x720  
/////////////////////////////////////////////*/
-(id)init;                                              //  640x480
-(id)initWithPreset:(NSString*)preset;

@property(nonatomic, weak) UIViewController<CameraManagerDelegate>* delegate;

@property (nonatomic, assign) BOOL processingToConvert;
@property (nonatomic, assign) int currentCapturedNumber;
@property (nonatomic, assign) int allCaptureNumber;
@property (nonatomic, assign) BOOL isRunning;

- (void)addAssetToCache:(LmCmImageAsset*)asset;
- (void)popCacheAndConvert;

- (void)takeOnePicture;
- (void)takeOnePicutreWithNoSound;
- (void)takeOnePicutreByNormalCamera;

- (void)enableCamera;
- (void)disableCamera;
- (void)deallocCamera;

- (NSString*)presetString;

/////////////////////////////////////////////////////////
//      プレビュー制御
////////////////////////////////////////////////////////
//      プレビューレイヤを直接設定できます
///     表示の ON/OFFは　previewLayer.hidden = YES/NO
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
@property AVCaptureDevice*                backCameraDevice;        //   バックカメラデバイス
@property AVCaptureDevice*                frontCameraDevice;       //   フロントカメラデバイス

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
-(void)takePhoto:(takePhotoBlock) block;


///////////////////////////////////////////
//      動画撮影
///////////////////////////////////////////
@property UIImage*                        videoImage;              //  キャプチャした生ビデオイメージ
@property UIDeviceOrientation             videoOrientaion;         //  キャプチャイメージの向き

//   静止画取得(シャッター音なし) 
-(UIImage*)rotatedVideoImage;                                      //  デバイスの向きに合わせたビデオイメージを作成

///////////////////////////////////////////////////
//      クラスメソッド
///////////////////////////////////////////////////
//    SampleBuffer -> CGImageRef変換
+(CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;
//      画像回転
+(UIImage*)rotateImage:(UIImage*)img angle:(int)angle;
+(UIImage*)fixOrientationOfImage:(UIImage *)image;

@end
