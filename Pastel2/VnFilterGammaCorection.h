//
//  VnFilterGammaCorection.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

@interface VnFilterGammaCorection : VnImageFilter

// 0.01 - 9.99
@property (nonatomic, assign) float gamma;

@end
