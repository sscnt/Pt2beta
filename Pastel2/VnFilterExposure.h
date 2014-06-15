//
//  VnFilterContrast.h
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

@interface VnFilterExposure : VnImageFilter

// -1 - +1
@property (nonatomic, assign) float exposure;

// -0.5 - +0.5
@property (nonatomic, assign) float offset;

// 0.01 - 9.99
@property (nonatomic, assign) float gamma;

@end
