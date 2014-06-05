//
//  LmViewManagerCameraPreview.m
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewManagerPreview.h"
#import "LmCmViewController.h"

@implementation LmCmViewManagerPreview

- (void)viewDidLoad
{
    LmCmViewController* _self = self.delegate;
    
    //// Grid
    _self.cameraPreviewOverlay.showGrid = [LmCmSharedCamera instance].showGrid;
    
    //// Tap
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTouchUpInside:)];
    [_self.cameraPreviewOverlay addGestureRecognizer:recognizer];
    
}

- (void)viewDidTouchUpInside:(UITapGestureRecognizer *)sender
{
    
    LmCmViewController* _self = self.delegate;
    
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint tapPoint = [sender locationInView:sender.view];
        
        float zoom = [LmCmSharedCamera instance].zoom;
        float width = [_self.cameraPreviewOverlay width] * zoom;
        float height = [_self.cameraPreviewOverlay height] * zoom;
        float rw = (width - [_self.cameraPreviewOverlay width]) / 2.0f;
        float rh = (height - [_self.cameraPreviewOverlay height]) / 2.0f;
        float x = tapPoint.y + rh;
        float y = tapPoint.x + rw;
        x = x / height;
        y = (width - y) / width;
        LOG(@"focus: (%f, %f)", x, y);
        [_self.cameraManager autoFocusAtPoint:CGPointMake(x, y)];
    }    
    
}

@end
