//
//  VnImageTwoPassFilter.h
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

@interface VnImageTwoPassFilter : VnImageFilter
{
    GLuint secondFilterOutputTexture;
    
    GLProgram *secondFilterProgram;
    GLint secondFilterPositionAttribute, secondFilterTextureCoordinateAttribute;
    GLint secondFilterInputTextureUniform, secondFilterInputTextureUniform2;
    
    GLuint secondFilterFramebuffer;
    
    NSMutableDictionary *secondProgramUniformStateRestorationBlocks;
}

// Initialization and teardown
- (id)initWithFirstStageVertexShaderFromString:(NSString *)firstStageVertexShaderString firstStageFragmentShaderFromString:(NSString *)firstStageFragmentShaderString secondStageVertexShaderFromString:(NSString *)secondStageVertexShaderString secondStageFragmentShaderFromString:(NSString *)secondStageFragmentShaderString;
- (id)initWithFirstStageFragmentShaderFromString:(NSString *)firstStageFragmentShaderString secondStageFragmentShaderFromString:(NSString *)secondStageFragmentShaderString;
- (void)initializeSecondaryAttributes;
- (void)initializeSecondOutputTextureIfNeeded;

// Managing the display FBOs
- (void)createSecondFilterFBOofSize:(CGSize)currentFBOSize;



@end
