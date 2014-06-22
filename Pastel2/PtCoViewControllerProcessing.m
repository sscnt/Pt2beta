//
//  PtCoViewControllerProcessing.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtCoViewControllerProcessing.h"
#import "PtViewControllerEditor.h"

@interface PtCoViewControllerProcessing ()

@end

@implementation PtCoViewControllerProcessing

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Preview
    float restHeight = self.view.height - [PtFtConfig colorBarHeight] - [PtFtConfig overlayBarHeight] - [PtFtConfig artisticBarHeight] - [PtSharedApp bottomNavigationBarHeight];
    float w, h;
    UIImage* image = [PtSharedApp instance].imageToProcess;
    if (image.size.width > image.size.height) {
        w = self.view.width;
        h = image.size.height * w / image.size.width;
    }else{
        h = restHeight - 40.0f;
        w = image.size.width * h / image.size.height;
    }
    self.previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, w, h)];
    self.previewImageView.center = CGPointMake(self.view.width / 2.0f, restHeight / 2.0f + 20.0f);
    [self.view addSubview:self.previewImageView];
    
    //// Blur
    self.blurView = [[PtFtViewBlur alloc] initWithFrame:self.view.bounds];
    self.blurView.center = self.previewImageView.center;
    [self.view addSubview:self.blurView];
    
    //// Progress
    self.progressView = [[VnViewProgress alloc] initWithFrame:self.previewImageView.frame Radius:16.0f];
    self.progressView.center = self.previewImageView.center;
    [self.progressView resetProgress];
    [self.view addSubview:self.progressView];
    
    //// Tap
    self.tapRecognizerView = [[PtFtViewTapRecognizer alloc] initWithFrame:self.previewImageView.frame];
    self.tapRecognizerView.delegate = self;
    [self.view addSubview:self.tapRecognizerView];
}

- (void)resizeImage
{
    
    __block __weak PtViewControllerFilters* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            CGSize size = CGSizeMake(_self.previewImageView.width * [[UIScreen mainScreen] scale], _self.previewImageView.height * [[UIScreen mainScreen] scale]);
            UIImage* image = [PtUtilImage resizedImageUrl:[PtSharedApp originalImageUrl] ToSize:size];
            _self.originalPreviewImage = image;
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.60f];
        });
        @autoreleasepool {
            UIImage* image = _self.originalPreviewImage;
            if (image) {
                //// for preset image
                CGSize presetImageSizeWithAspect = [PtFtConfig presetBaseImageSize];
                if (image.size.width > image.size.height) {
                    presetImageSizeWithAspect.width = image.size.width * presetImageSizeWithAspect.height / image.size.height;
                } else {
                    presetImageSizeWithAspect.height = image.size.height * presetImageSizeWithAspect.width / image.size.width;
                }
                image = [image resizedImage:presetImageSizeWithAspect interpolationQuality:kCGInterpolationHigh];
                float x = 0.0f;
                float y = 0.0f;
                CGSize presetImageSize = [PtFtConfig presetBaseImageSize];
                if (image.size.width > image.size.height) {
                    x = (image.size.width - presetImageSize.width) / 2.0f;
                } else {
                    y = (image.size.height - presetImageSize.height) / 2.0f;
                }
                image = [image croppedImage:CGRectMake(x, y, presetImageSize.width, presetImageSize.height)];
                _self.presetOriginalImage = image;
            }
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.90f];
        });
        @autoreleasepool {
            /*
             if (YES) {
             
             }else{
             //// Detect faces
             NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
             CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
             CIImage *ciImage = [[CIImage alloc] initWithCGImage:_self.previewImage.CGImage];
             NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CIDetectorImageOrientation];
             NSArray *array = [detector featuresInImage:ciImage options:imageOptions];
             
             if([array count] > 0){
             LOG(@"Face detected!");
             _self.faceDetected = YES;
             }
             }
             */
        }
        dispatch_async(q_main, ^{
            [_self didResizeImage];
        });
    });

}

#pragma mark tap

- (void)tapRecognizerDidTouchUp
{
    if (self.previewImage) {
        self.previewImageView.image = self.previewImage;
    }
}

- (void)tapRecognizerDidTouchDown
{
    self.previewImageView.image = self.originalPreviewImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
