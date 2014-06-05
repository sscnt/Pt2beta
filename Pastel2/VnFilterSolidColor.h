//
//  VnFilterSolidColor.h
//  Pastel2
//
//  Created by SSC on 2014/05/29.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

@interface VnFilterSolidColor : VnImageFilter

{
    GLint colorUniform;
    GLint useExistingAlphaUniform;
}

// This color dictates what the output image will be filled with
@property(readwrite, nonatomic) GPUVector4 color;
@property(readwrite, nonatomic, assign) BOOL useExistingAlpha; // whether to use the alpha of the existing image or not, default is NO

- (void)setColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent alpha:(GLfloat)alphaComponent;


@end
