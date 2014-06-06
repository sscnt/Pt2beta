//
//  CameraManager.m
//  CameraTemplate
//
//  Created by Takashi Otsuka on 2013/06/16.
//  Copyright (c) 2013年 takatronix.com. All rights reserved.
//

#import "LmCmCamera.h"

@interface LmCmCamera(){
    
    AVCaptureSession*               captureSession;
    AVCaptureDeviceInput*           videoInput;             //  現在のビデオ入力デバイス
    
    AVCaptureStillImageOutput*      imageOutput;            //  静止画出力デバイス
    AVCaptureAudioDataOutput*       audioOutput;            //  オーディオ出力デバイス
    AVCaptureVideoDataOutput*       videoOutput;            //  ビデオ出力デバイス
    dispatch_queue_t                videoOutputQueue;       //  ビデオ出力用スレッド
    dispatch_queue_t                audioOutputQueue;       //  オーディオ出力用スレッド
}

//          ユーティリティ
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition)position;
- (AVCaptureDevice *) frontFacingCamera;
- (AVCaptureDevice *) backFacingCamera;
- (AVCaptureDevice *) audioDevice;

@end

@implementation LmCmCamera


#pragma mark - カメラ切り替え

-(void)useFrontCamera:(BOOL)yesno{
    
    if(yesno == YES){
        [self enableCamera:AVCaptureDevicePositionFront];
    }else{
        [self enableCamera:AVCaptureDevicePositionBack];
    }
    
}
-(void)flipCamera{
    
    if(self.isUsingFrontCamera)
        [self useFrontCamera:NO];
    else
        [self useFrontCamera:YES];
}
//     カメラを有効化する
-(void)enableCamera:(AVCaptureDevicePosition)desiredPosition{
    [captureSession stopRunning];
    
    for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([d position] == desiredPosition) {
            [captureSession beginConfiguration];
            videoInput= [AVCaptureDeviceInput deviceInputWithDevice:d error:nil];
            for (AVCaptureInput *oldInput in [[_previewLayer session] inputs]) {
                [captureSession removeInput:oldInput];
            }
            [captureSession addInput:videoInput];
            [captureSession commitConfiguration];
            break;
        }
    }
    [captureSession startRunning];
}

- (void)enableCamera
{
    LOG(@"Camera Enabled.");
    [captureSession startRunning];
}

- (void)disableCamera
{
    LOG(@"Camera Disabled.");
    [captureSession stopRunning];
}

- (void)deallocCamera
{
    [self disableCamera];
    
    for (AVCaptureOutput *output in captureSession.outputs) {
        [captureSession removeOutput:output];
    }
    for (AVCaptureInput *input in captureSession.inputs) {
        [captureSession removeInput:input];
    }
}

-(BOOL)isUsingFrontCamera{
    
    //      フロントカメラを使っているか
    if(videoInput.device.position == AVCaptureDevicePositionFront)
        return YES;
    
    return NO;
}

#pragma mark - ライト制御

- (void)flash:(BOOL)enabled
{
    [_backCameraDevice lockForConfiguration:nil];
    if (enabled) {
        _backCameraDevice.flashMode = AVCaptureFlashModeOn;
    }else{
        _backCameraDevice.flashMode = AVCaptureFlashModeOff;
    }
    [_backCameraDevice unlockForConfiguration];
}

- (void)autoFlash:(BOOL)enabled
{
    [_backCameraDevice lockForConfiguration:nil];
    if (enabled) {
        _backCameraDevice.flashMode = AVCaptureFlashModeAuto;
    }else{
        _backCameraDevice.flashMode = AVCaptureFlashModeOff;
    }
    [_backCameraDevice unlockForConfiguration];
}

-(void)lightToggle{
    if(self.isLightOn)
        [self light:NO];
    else
        [self light:YES];
}

-(void)light:(BOOL)yesno{
    
    if(![_backCameraDevice hasTorch])
        return;
    
    //      フロントカメラ使用中ならバックカメラに切り替え
    if(self.isUsingFrontCamera){
        [self useFrontCamera:NO];
    }
    
    NSError* error;
    [_backCameraDevice lockForConfiguration:&error];
    if(yesno == YES)
        _backCameraDevice.torchMode = AVCaptureTorchModeOn;
    else
        _backCameraDevice.torchMode = AVCaptureTorchModeOff;
    
    [_backCameraDevice unlockForConfiguration];
    
}
-(BOOL)isLightOn{
    
    
    if(![_backCameraDevice hasTorch])
        return NO;
    
    if(_backCameraDevice.isTorchActive)
        return YES;
    
    return NO;
}

#pragma mark - フォーカス制御

- (void) autoFocusAtPoint:(CGPoint)point
{
    AVCaptureDevice *device = videoInput.device;
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            [device setFocusPointOfInterest:point];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            [device unlockForConfiguration];
        }    }
}


- (void) continuousFocusAtPoint:(CGPoint)point
{
    AVCaptureDevice *device = videoInput.device;
	
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
		NSError *error;
		if ([device lockForConfiguration:&error]) {
			[device setFocusPointOfInterest:point];
			[device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
			[device unlockForConfiguration];
		}
	}
}

#pragma  mark - 初期化

//      デフォルト初期化
-(id)init
{
    self = [super init];
    if(self){
        if ([LmCmSharedCamera instance].soundEnabled) {
            [self setupAVCapture:AVCaptureSessionPresetPhoto];
        }else{
            if ([UIDevice isIOS6]) {
                [self setupAVCapture:AVCaptureSessionPresetHigh];
            }else{
                if ([UIDevice underIPhone5]) {
                    [self setupAVCapture:AVCaptureSessionPresetHigh];
                }else{
                    [self setupAVCapture:AVCaptureSessionPresetInputPriority];
                }
            }
        }
        return self;
    }
    return nil;
}





//      解像度指定して初期化
-(id)initWithPreset:(NSString*)preset{
    
    if(super.init){
        [self setupAVCapture:preset];
        
        return self;
    }
    
    return nil;
}

//      プレビューレイヤをビューに設定する
-(void)setPreview:(UIView*)view{
    
    _previewLayer.frame = view.bounds;
    [view.layer addSublayer:_previewLayer];
    
}

//
- (void)setupAVCapture:(NSString*)preset{
    
    /////////////////////////////////////////////////
    //    カメラの一覧を取得しカメラデバイスを保存
    /////////////////////////////////////////////////
    self.backCameraDevice = nil;
    self.frontCameraDevice = nil;
    
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    
    NSArray*    cameraArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *camera in cameraArray){
        if(camera.position == AVCaptureDevicePositionBack){
            self.backCameraDevice = camera;
            if ([camera lockForConfiguration:nil]) {
                for ( AVCaptureDeviceFormat *format in [camera formats] ) {
                    for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges ) {
                        if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate ) {
                            bestFormat = format;
                            bestFrameRateRange = range;
                        }
                    }
                    bestFormat = format;
                }
                if ([UIDevice underIPhone5]) {
                    bestFormat = [[camera formats] objectAtIndex:[[camera formats] count] - 5];
                }else{
                    bestFormat = [[camera formats] objectAtIndex:[[camera formats] count] - 1];
                }
                LOG(@"%@", bestFormat);
                if (bestFormat) {
                    camera.activeFormat = bestFormat;
                    //[camera setActiveVideoMinFrameDuration:bestFrameRateRange.minFrameDuration];
                    //[camera setActiveVideoMaxFrameDuration:bestFrameRateRange.maxFrameDuration];
                    if ([UIDevice isIOS6]) {
                        
                    }else{
                        [camera setActiveVideoMinFrameDuration:CMTimeMake(1, 5)];
                        [camera setActiveVideoMaxFrameDuration:CMTimeMake(1, 5)];
                    }
                    [camera unlockForConfiguration];
                }
            }
        }
        if(camera.position == AVCaptureDevicePositionFront)
            self.frontCameraDevice = camera;
    }
    
    //      デフォルトはバックカメラ
    videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.backCameraDevice error:nil];
    
    /////////////////////////////////////////////////
    //      キャプチャセッションの作成
    /////////////////////////////////////////////////
	captureSession = AVCaptureSession.new;
    [captureSession setSessionPreset:preset];
    [captureSession addInput:videoInput];
    
  	self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
	[self.previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    [self setupImageCapture];
    [self setupVideoCapture];
    
    
    [captureSession startRunning];
}

- (BOOL)isRunning
{
    return captureSession.isRunning;
}

/////////////////////////////////////////////////
//      静止画キャプチャの初期化
//      設定後:captureOutputが呼ばれる
/////////////////////////////////////////////////
-(BOOL)setupImageCapture{
    
    imageOutput = AVCaptureStillImageOutput.new;
    if(imageOutput){
        if([captureSession canAddOutput:imageOutput]){
            [captureSession addOutput:imageOutput];
            return YES;
        }
    }
    
    return NO;
}

/////////////////////////////////////////////////
//      ビデオキャプチャの初期化
//      設定後:captureOutputが呼ばれる
/////////////////////////////////////////////////
-(BOOL)setupVideoCapture{
    
    
    //////////////////////////////////
    //    ビデオ出力デバイスの設定
    //////////////////////////////////
	NSDictionary *rgbOutputSettings = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCMPixelFormat_32BGRA)};
    videoOutput = AVCaptureVideoDataOutput.new;
	[videoOutput setVideoSettings:rgbOutputSettings];
	[videoOutput setAlwaysDiscardsLateVideoFrames:YES];     //  NOだとコマ落ちしないが重い処理には向かない
    
  	videoOutputQueue = dispatch_queue_create("VideoData Output Queue", DISPATCH_QUEUE_SERIAL);
	[videoOutput setSampleBufferDelegate:self queue:videoOutputQueue];
    
	if(videoOutput){
        if ([captureSession canAddOutput:videoOutput]){
            [captureSession addOutput:videoOutput];
            return YES;
        }
    }
    return NO;
}

///////////////////////////////////////////
//      オーディオキャプチャの初期化
//      設定後:captureOutputが呼ばれる
///////////////////////////////////////////
-(BOOL)setupAudioCapture{
    
    audioOutput = AVCaptureAudioDataOutput.new;
    audioOutputQueue = dispatch_queue_create("Audio Capture Queue", DISPATCH_QUEUE_SERIAL);
	[audioOutput setSampleBufferDelegate:self queue:audioOutputQueue];
    if(audioOutput){
        
        if ([captureSession canAddOutput:audioOutput]){
            [captureSession addOutput:audioOutput];
            return YES;
        }
    }
    return NO;
}

/////////////////////////////////////////////////////////////////////////////////
//      ビデオキャプチャ時、 新しいフレームが書き込まれた際に通知を受けるデリゲートメソッド
/////////////////////////////////////////////////////////////////////////////////
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    @autoreleasepool {
        if (_currentCapturedNumber < _allCaptureNumber) {
            AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if (device.adjustingFocus) {
                LOG(@"Sorry adjusting focus.");
                return;
            }
            _currentCapturedNumber++;
            LmCmSharedCamera* camera = [LmCmSharedCamera instance];
            LmCmImageAsset* asset = [[LmCmImageAsset alloc] init];
            
            CGImageRef cgImage = [PtUtilImage imageFromSampleBuffer:sampleBuffer];
            asset.image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            
            asset.zoom = camera.zoom;
            asset.cropSize = camera.cropSize;
            asset.frontCamera = [self isUsingFrontCamera];
            asset.orientation = [MotionOrientation sharedInstance].deviceOrientation;
            asset.originalSize = asset.image.size;
            
            [self.delegate performSelectorOnMainThread:@selector(singleImageNoSoundDidTakeWithAsset:) withObject:asset waitUntilDone:NO];
            return;
        }
    }
}


#pragma mark - ユーティリティ

- (NSUInteger) cameraCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

- (NSUInteger) micCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] count];
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *) frontFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *) backFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDevice *) audioDevice
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if ([devices count] > 0) {
        return [devices objectAtIndex:0];
    }
    return nil;
}

#pragma mark Shooting

- (void)takeOnePicture
{
    if ([LmCmSharedCamera instance].soundEnabled) {
        [self takeOnePicutreByNormalCamera];
        return;
    }
    [self takeOnePicutreWithNoSound];
}

- (void)takeOnePicutreWithNoSound
{
    if (_processingToConvert) {
        return;
    }
    _processingToConvert = YES;
    _allCaptureNumber = 1;
    _currentCapturedNumber = 0;
}

- (void)takeOnePicutreByNormalCamera
{
    AVCaptureConnection* connection = [imageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //      画像の向きを調整する
    if(connection.isVideoOrientationSupported){
        connection.videoOrientation = [MotionOrientation sharedInstance].deviceOrientation;
    }
    
    __block __weak LmCmCamera* _self = self;
    //      UIImage化した画像を通知する
    [imageOutput captureStillImageAsynchronouslyFromConnection:connection
                                             completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                 if(imageDataSampleBuffer == nil){
                                                     return;
                                                 }
                                                 UIImage* image;
                                                 @autoreleasepool {
                                                     NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                     image = [[UIImage alloc] initWithData:data];
                                                 }
                                                 @autoreleasepool {
                                                     image = [PtUtilImage fixOrientationOfImageFromCamera:image];
                                                 }
                                                 
                                                 LmCmSharedCamera* camera = [LmCmSharedCamera instance];
                                                 LmCmImageAsset* asset = [[LmCmImageAsset alloc] init];
                                                 asset.image = image;
                                                 asset.zoom = camera.zoom;
                                                 asset.cropSize = camera.cropSize;
                                                 asset.orientation = [MotionOrientation sharedInstance].deviceOrientation;
                                                 asset.frontCamera = [_self isUsingFrontCamera];
                                                 [_self.delegate singleImageByNormalCameraDidTakeWithAsset:asset];
                                                 
                                             }];
    
    
}


@end
