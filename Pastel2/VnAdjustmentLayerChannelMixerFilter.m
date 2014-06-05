//
//  GPUImageChannelMixerFilter.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnAdjustmentLayerChannelMixerFilter.h"

@implementation VnAdjustmentLayerChannelMixerFilter

NSString *const kVnAdjustmentLayerChannelMixerFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 uniform mediump float redRed; // 1.0 base
 uniform mediump float redGreen; // 0.0 base
 uniform mediump float redBlue; // 0.0 base
 uniform mediump float redConstant;
 uniform mediump float greenRed;
 uniform mediump float greenGreen;
 uniform mediump float greenBlue;
 uniform mediump float greenConstant;
 uniform mediump float blueRed;
 uniform mediump float blueGreen;
 uniform mediump float blueBlue;
 uniform mediump float blueConstant;
 uniform mediump float greyRed;
 uniform mediump float greyGreen;
 uniform mediump float greyBlue;
 uniform mediump float greyConstant;
 uniform int monochrome;

 
 void main()
 {
     // Sample the input pixel
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     mediump float r = pixel.r;
     mediump float g = pixel.g;
     mediump float b = pixel.b;
     mediump float _r;
     mediump float _g;
     mediump float _b;
     
     if(monochrome == 1){
         _r = r * greyRed;
         _g = g * greyGreen;
         _b = b * greyBlue;
         
         //r = max(0.0, min(1.0, _r));
         //g = max(0.0, min(1.0, _g));
         //b = max(0.0, min(1.0, _b));
         
         mediump float lumi = _r + _g + _b;
         lumi += greyConstant;
         lumi = max(min(lumi, 1.0), 0.0);
         
         rs.r = lumi;
         rs.g = lumi;
         rs.b = lumi;
         
     } else {
         _r = r * redRed + r + redConstant + g * redGreen + b * redBlue;
         _g = g * greenGreen + g + greenConstant + r * greenRed + b * greenBlue;
         _b = b * blueBlue + b + blueConstant + r * blueRed + g * blueGreen;
         
         r = max(0.0, min(1.0, _r));
         g = max(0.0, min(1.0, _g));
         b = max(0.0, min(1.0, _b));
         
         rs.r = r;
         rs.g = g;
         rs.b = b;
     }
     
     // Save the result
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );


#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnAdjustmentLayerChannelMixerFilterFragmentShaderString]))
    {
        return nil;
    }
    redRedUniform = [filterProgram uniformIndex:@"redRed"];
    redGreenUniform = [filterProgram uniformIndex:@"redGreen"];
    redBlueUniform = [filterProgram uniformIndex:@"redBlue"];
    redConstantUniform = [filterProgram uniformIndex:@"redConstant"];
    
    greenRedUniform = [filterProgram uniformIndex:@"greenRed"];
    greenGreenUniform = [filterProgram uniformIndex:@"greenGreen"];
    greenBlueUniform = [filterProgram uniformIndex:@"greenBlue"];
    greenConstantUniform = [filterProgram uniformIndex:@"greenConstant"];
    
    blueRedUniform = [filterProgram uniformIndex:@"blueRed"];
    blueGreenUniform = [filterProgram uniformIndex:@"blueGreen"];
    blueBlueUniform = [filterProgram uniformIndex:@"blueBlue"];
    blueConstantUniform = [filterProgram uniformIndex:@"blueConstant"];
    
    greyRedUniform = [filterProgram uniformIndex:@"greyRed"];
    greyGreenUniform = [filterProgram uniformIndex:@"greyGreen"];
    greyBlueUniform = [filterProgram uniformIndex:@"greyBlue"];
    greyConstantUniform = [filterProgram uniformIndex:@"greyConstant"];
    
    monochromeUniform = [filterProgram uniformIndex:@"monochrome"];
    
    self.monochrome = NO;
    
    return self;
}

- (void)setMonochrome:(BOOL)monochrome
{
    _monochrome = monochrome;
    [self setInteger:(int)monochrome forUniform:monochromeUniform program:filterProgram];
}

- (void)setRedChannelRed:(int)red Green:(int)green Blue:(int)blue Constant:(int)constant
{
    [self setFloat:(float)(red - 100) / 100.0f forUniform:redRedUniform program:filterProgram];
    [self setFloat:(float)green / 100.0f forUniform:redGreenUniform program:filterProgram];
    [self setFloat:(float)blue / 100.0f forUniform:redBlueUniform program:filterProgram];
    [self setFloat:(float)constant / 100.0f forUniform:redConstantUniform program:filterProgram];
}

- (void)setGreenChannelRed:(int)red Green:(int)green Blue:(int)blue Constant:(int)constant
{
    [self setFloat:(float)red / 100.0f forUniform:greenRedUniform program:filterProgram];
    [self setFloat:(float)(green - 100) / 100.0f forUniform:greenGreenUniform program:filterProgram];
    [self setFloat:(float)blue / 100.0f forUniform:greenBlueUniform program:filterProgram];
    [self setFloat:(float)constant / 100.0f forUniform:greenConstantUniform program:filterProgram];
}

- (void)setBlueChannelRed:(int)red Green:(int)green Blue:(int)blue Constant:(int)constant
{
    [self setFloat:(float)red / 100.0f forUniform:blueRedUniform program:filterProgram];
    [self setFloat:(float)green / 100.0f forUniform:blueGreenUniform program:filterProgram];
    [self setFloat:(float)(blue - 100) / 100.0f forUniform:blueBlueUniform program:filterProgram];
    [self setFloat:(float)constant / 100.0f forUniform:blueConstantUniform program:filterProgram];
}

- (void)setGreyChannelRed:(int)red Green:(int)green Blue:(int)blue Constant:(int)constant
{
    [self setFloat:(float)red / 100.0f forUniform:greyRedUniform program:filterProgram];
    [self setFloat:(float)green / 100.0f forUniform:greyGreenUniform program:filterProgram];
    [self setFloat:(float)blue / 100.0f forUniform:greyBlueUniform program:filterProgram];
    [self setFloat:(float)constant / 100.0f forUniform:greyConstantUniform program:filterProgram];
}

@end
