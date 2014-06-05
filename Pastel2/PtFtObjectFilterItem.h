//
//  PtFtObjectFilterItem.h
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtFtObjectFilterItem : NSObject

@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) VnEffectGroup effectGroup;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) UIColor* previewColor;
@property (nonatomic, strong) UIColor* selectionColor;

@end
