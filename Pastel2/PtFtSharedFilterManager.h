//
//  PtFtSharedFilterManager.h
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtFtObjectProcessQueue.h"
#import "PtFtObjectFilterItem.h"

#import "VnEffectColorBronze.h"
#import "VnEffectColorLittleBlueSecret.h"
#import "VnEffectColorPurrr.h"
#import "VnEffectColorBronze.h"
#import "VnEffectColorOphelia.h"
#import "VnEffectColorPotion9.h"
#import "VnEffectColorPinkMilk.h"
#import "VnEffectColorPurePeach.h"
#import "VnEffectColorRosyVintage.h"
#import "VnEffectColorSerenity.h"
#import "VnEffectColorSummerSkin.h"
#import "VnEffectColorSunnyLight.h"
#import "VnEffectColorUrbanCandy.h"
#import "VnEffectColorVintageMatte.h"
#import "VnEffectColorWarmHaze.h"
#import "VnEffectColorWildHoney.h"

#import "VnEffectOverlayBlueHaze.h"
#import "VnEffectOverlayHazyLightWarmPink.h"
#import "VnEffectOverlayHazyLightWarmPink2.h"
#import "VnEffectOverlayLightBrightHaze.h"
#import "VnEffectOverlayLightBrightPop.h"
#import "VnEffectOverlayLightBrightMatte.h"
#import "VnEffectOverlayPinkHaze.h"
#import "VnEffectOverlayRetroSun.h"
#import "VnEffectOverlayWarmVintage.h"
#import "VnEffectOverlayCandyHaze.h"
#import "VnEffectOverlaySunhazeLeft.h"
#import "VnEffectOverlaySunhazeRight.h"

#import "VnEffectBeachVintage.h"
#import "VnEffectBellerina.h"
#import "VnEffectBlueBerry.h"
#import "VnEffectBluishRose.h"
#import "VnEffectCarnival.h"
#import "VnEffectCavalleriaRusticana.h"
#import "VnEffectDreamyCreamy.h"
#import "VnEffectDreamyVintage.h"
#import "VnEffectDonut.h"
#import "VnEffectFaerieVintage.h"
#import "VnEffectFruitPop.h"
#import "VnEffectGentleColor.h"
#import "VnEffectGentleMemories.h"
#import "VnEffectGirder.h"
#import "VnEffectGreenApple.h"
#import "VnEffectHazelnut.h"
#import "VnEffectHazelnutPink.h"
#import "VnEffectJoyful.h"
#import "VnEffectPinkBubbleTea.h"
#import "VnEffectPurpleBerry.h"
#import "VnEffectVelvetColor.h"
#import "VnEffectVividVintage.h"
#import "VnEffectVintageFilm.h"
#import "VnEffectWeekend.h"
#import "VnEffectHappy.h"
#import "VnEffectSweetFlower.h"
#import "VnEffectFresnoFaded.h"
#import "VnEffectWaldenFaded.h"
#import "VnEffectGlitterShine.h"
#import "VnEffectAmaroFaded.h"
#import "VnEffectLanikaiFaded.h"
#import "VnEffectFrontpageFaded.h"
#import "VnEffectKodakPortra800.h"
#import "VnEffectPx680.h"
#import "VnEffectFujiSuperia800.h"
#import "VnEffectFujiSuperia1600.h"
#import "VnEffectQouziFaded.h"
#import "VnEffectOverlayRetroSun.h"
#import "VnEffectDeutanFaded.h"
#import "VnEffectBrannanFaded.h"
#import "VnEffectFixieFaded.h"
#import "VnEffectLeningradFaded.h"
#import "VnEffectNashvilleFaded.h"
#import "VnEffectXPro2Faded.h"
#import "VnEffectVintageSummer.h"
#import "VnEffectVintageWine.h"
#import "VnEffectVintageHaze.h"

@interface PtFtSharedFilterManager : NSObject

@property (nonatomic, strong) NSMutableArray* artisticFilters;
@property (nonatomic, strong) NSMutableArray* overlayFilters;
@property (nonatomic, strong) NSMutableArray* colorFilters;

+ (PtFtSharedFilterManager*)instance;
+ (UIImage*)applyEffect:(VnEffectId)effectId ToImage:(UIImage*)image WithOpacity:(float)opacity;
+ (VnEffect*)effectByEffectId:(VnEffectId)effectId;

+ (float)defaultOpacityOfEffect:(VnEffectId)effectId;
+ (float)faceOpacityOfEffect:(VnEffectId)effectId;

- (void)commonInit;
- (void)initColorFilters;
- (void)initOverlayFilters;
- (void)initArtisticFilters;

@end
