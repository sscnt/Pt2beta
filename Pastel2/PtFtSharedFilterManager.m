//
//  PtFtSharedFilterManager.m
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtSharedFilterManager.h"

@implementation PtFtSharedFilterManager

static PtFtSharedFilterManager* sharedPtFtSharedFilterManager = nil;

+ (PtFtSharedFilterManager*)instance {
	@synchronized(self) {
		if (sharedPtFtSharedFilterManager == nil) {
			sharedPtFtSharedFilterManager = [[self alloc] init];
		}
	}
	return sharedPtFtSharedFilterManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPtFtSharedFilterManager == nil) {
			sharedPtFtSharedFilterManager = [super allocWithZone:zone];
			return sharedPtFtSharedFilterManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark init

- (void)commonInit
{
    [self initArtisticFilters];
    [self initColorFilters];
    [self initOverlayFilters];
}

- (void)initArtisticFilters
{
    _artisticFilters = [NSMutableArray array];
    PtFtObjectFilterItem* item;
    
    //// None
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdNone;
    item.name = NSLocalizedString(NSLocalizedString(@"None", nil), nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Bellerina
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBellerina;
    item.name = NSLocalizedString(@"H1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Beach Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBeachVintage;
    item.name = NSLocalizedString(@"K2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
}

- (void)initColorFilters
{
    PtFtObjectFilterItem* item;
    _colorFilters = [NSMutableArray array];
    
    //// None
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorNone;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(NSLocalizedString(@"None", nil), nil);
    item.previewColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Bronze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorBronze;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(219.0f) blue:s255(194.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Little Blue Secret
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorLittleBlueSecret;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"W1", nil);
    item.previewColor = [UIColor colorWithRed:s255(205.0f) green:s255(201.0f) blue:s255(255.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Ophelia
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorOphelia;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"R1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(196.0f) blue:s255(220.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Pink Milk
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorPinkMilk;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"R2", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(204.0f) blue:s255(229.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Potion 9
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorPotion9;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"R3", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(196.0f) blue:s255(208.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Pure Peach
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorPurePeach;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"R4", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(202.0f) blue:s255(199.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Purrr
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorPurrr;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"W2", nil);
    item.previewColor = [UIColor colorWithRed:s255(227.0f) green:s255(209.0f) blue:s255(255.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Rosy Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorRosyVintage;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"R5", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(222.0f) blue:s255(222.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Serenity
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorSerenity;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"W3", nil);
    item.previewColor = [UIColor colorWithRed:s255(217.0f) green:s255(196.0f) blue:s255(255.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Summer Skin
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorSummerSkin;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P2", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(223) blue:s255(199.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Sunny Light
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorSunnyLight;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P3", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(242.0f) blue:s255(212.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Wild Honey
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorWildHoney;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P4", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(207.0f) blue:s255(214.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Urban Candy
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorUrbanCandy;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"W4", nil);
    item.previewColor = [UIColor colorWithRed:s255(241.0f) green:s255(224.0f) blue:s255(255.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Vintage Matte
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorVintageMatte;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P5", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(216.0f) blue:s255(201.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
    
    //// Warm Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdColorWarmHaze;
    item.effectGroup = VnEffectGroupColor;
    item.name = NSLocalizedString(@"P6", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(216.0f) blue:s255(191.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_colorFilters addObject:item];
}

- (void)initOverlayFilters
{
    _overlayFilters = [NSMutableArray array];
    PtFtObjectFilterItem* item;
    
    //// None
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayNone;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(NSLocalizedString(@"None", nil), nil);
    item.previewColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Gentle Color
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGentleColor;
    item.name = NSLocalizedString(@"A1", nil);
    item.effectGroup = VnEffectGroupOverlays;
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(241.0f) blue:s255(227.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Bright Matte
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayLightBrightMatte;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"A2", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(229.0f) blue:s255(217.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Candy Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayCandyHaze;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"B1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(231.0f) blue:s255(204.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Retro Sun
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayRetroSun;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"C1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(221.0f) blue:s255(201.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Pink Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayPinkHaze;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"D1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(229.0f) blue:s255(233.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Hazy Light Warm Pink
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayHazyLightWarmPink;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"D2", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(216.0f) blue:s255(212.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Hazy Light Warm Pink
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayHazyLightWarmPink2;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"D3", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(216.0f) blue:s255(212.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Light Bright Pop
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayLightBrightPop;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"E1", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(241.0f) blue:s255(227.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Light Bright Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayLightBrightHaze;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"D4", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(224.0f) blue:s255(245.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Blue Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayBlueHaze;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"F1", nil);
    item.previewColor = [UIColor colorWithRed:s255(191.0f) green:s255(191.0f) blue:s255(255.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Warm Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlayWarmVintage;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"C2", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(245.0f) blue:s255(224.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Sunhaze Left
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlaySunhazeLeft;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"C3", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(245.0f) blue:s255(224.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
    
    //// Sunhaze Right
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdOverlaySunhazeRight;
    item.effectGroup = VnEffectGroupOverlays;
    item.name = NSLocalizedString(@"C4", nil);
    item.previewColor = [UIColor colorWithRed:s255(255.0f) green:s255(245.0f) blue:s255(224.0f) alpha:1.0f];
    item.selectionColor = item.previewColor;
    [_overlayFilters addObject:item];
}

#pragma mark getter

+ (VnEffect *)effectByEffectId:(VnEffectId)effectId
{
    VnEffect* effect;
    
    switch (effectId) {
            //// Color
        case VnEffectIdColorPurrr:
            return [VnEffectColorPurrr new];
        case VnEffectIdColorBronze:
            return [VnEffectColorBronze new];
        case VnEffectIdColorOphelia:
            return [VnEffectColorOphelia new];
        case VnEffectIdColorPotion9:
            return [VnEffectColorPotion9 new];
        case VnEffectIdColorPinkMilk:
            return [VnEffectColorPinkMilk new];
        case VnEffectIdColorSerenity:
            return [VnEffectColorSerenity new];
        case VnEffectIdColorWarmHaze:
            return [VnEffectColorWarmHaze new];
        case VnEffectIdColorPurePeach:
            return [VnEffectColorPurePeach new];
        case VnEffectIdColorWildHoney:
            return [VnEffectColorWildHoney new];
        case VnEffectIdColorSummerSkin:
            return [VnEffectColorSummerSkin new];
        case VnEffectIdColorSunnyLight:
            return [VnEffectColorSunnyLight new];
        case VnEffectIdColorUrbanCandy:
            return [VnEffectColorUrbanCandy new];
        case VnEffectIdColorRosyVintage:
            return [VnEffectColorRosyVintage new];
        case VnEffectIdColorVintageMatte:
            return [VnEffectColorVintageMatte new];
        case VnEffectIdColorLittleBlueSecret:
            return [VnEffectColorLittleBlueSecret new];
            //// Overlay
        case VnEffectIdOverlayBlueHaze:
            return [VnEffectOverlayBlueHaze new];
        case VnEffectIdOverlayPinkHaze:
            return [VnEffectOverlayPinkHaze new];
        case VnEffectIdOverlayRetroSun:
            return [VnEffectOverlayRetroSun new];
        case VnEffectIdOverlayCandyHaze:
            return [VnEffectOverlayCandyHaze new];
        case VnEffectIdOverlaySunhazeLeft:
            return [VnEffectOverlaySunhazeLeft new];
        case VnEffectIdOverlayWarmVintage:
            return [VnEffectOverlayWarmVintage new];
        case VnEffectIdOverlaySunhazeRight:
            return [VnEffectOverlaySunhazeRight new];
        case VnEffectIdOverlayLightBrightPop:
            return [VnEffectOverlayLightBrightPop new];
        case VnEffectIdOverlayLightBrightHaze:
            return [VnEffectOverlayLightBrightHaze new];
        case VnEffectIdOverlayLightBrightMatte:
            return [VnEffectOverlayLightBrightMatte new];
        case VnEffectIdOverlayHazyLightWarmPink:
            return [VnEffectOverlayHazyLightWarmPink new];
        case VnEffectIdOverlayHazyLightWarmPink2:
            return [VnEffectOverlayHazyLightWarmPink2 new];
            //// Artistic
        case VnEffectIdBeachVintage:
            return [VnEffectBeachVintage new];
        case VnEffectIdBellerina:
            return [VnEffectBellerina new];
        default:
            break;
    }
    return nil;
}

#pragma mark process

+ (UIImage *)applyEffect:(VnEffectId)effectId ToImage:(UIImage *)image WithOpacity:(float)opacity
{
    VnEffect* effect = [self effectByEffectId:effectId];
    if (effect) {
        [effect makeFilterGroup];
        if (opacity == 1.0f) {
            return [VnEffect processImage:image WithStartFilter:effect.startFilter EndFilter:effect.endFilter];
        }
        return [VnEffect processImage:image WithStartFilter:effect.startFilter EndFilter:effect.endFilter];
    }
    return nil;
}

#pragma mark opacity

+ (float)defaultOpacityOfEffect:(VnEffectId)effectId
{
    VnEffect* effect = [self effectByEffectId:effectId];
    if (effect) {
        return effect.defaultOpacity;
    }
    return 0.0f;
}

+ (float)faceOpacityOfEffect:(VnEffectId)effectId
{
    VnEffect* effect = [self effectByEffectId:effectId];
    if (effect) {
        return effect.faceOpacity;
    }
    return 0.0f;
}

@end
