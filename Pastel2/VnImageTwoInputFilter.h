//
//  VnImageTwoInputFilter.h
//  Pastel2
//
//  Created by SSC on 2014/06/02.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

extern NSString *const kVnImageTwoInputFilterVertexShaderString;

@interface VnImageTwoInputFilter : VnImageFilter
{
    GLint filterSecondTextureCoordinateAttribute;
    GLint filterInputTextureUniform2;
    GPUImageRotationMode inputRotation2;
    GLuint filterSourceTexture2;
    CMTime firstFrameTime, secondFrameTime;
    
    BOOL hasSetFirstTexture, hasReceivedFirstFrame, hasReceivedSecondFrame, firstFrameWasVideo, secondFrameWasVideo;
    BOOL firstFrameCheckDisabled, secondFrameCheckDisabled;
    
    __unsafe_unretained id<GPUImageTextureDelegate> secondTextureDelegate;
}

- (void)disableFirstFrameCheck;
- (void)disableSecondFrameCheck;

@end
