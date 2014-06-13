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
    item.name = NSLocalizedString(@"M1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Carnival
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdCarnival;
    item.name = NSLocalizedString(@"M2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Girder
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGirder;
    item.name = NSLocalizedString(@"VX1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Joyful
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdJoyful;
    item.name = NSLocalizedString(@"VX2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Happy
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdHappy;
    item.name = NSLocalizedString(@"VX3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Vintage Wine
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdVintageWine;
    item.name = NSLocalizedString(@"VX4", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Soft Cream
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdSoftCream;
    item.name = NSLocalizedString(@"VX5", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Vintage Haze
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdVintageHaze;
    item.name = NSLocalizedString(@"VX6", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Vintage Film
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGlitterShine;
    item.name = NSLocalizedString(@"FX1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];

    //// Weekend
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdWeekend;
    item.name = NSLocalizedString(@"V1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Hazelnut
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdHazelnut;
    item.name = NSLocalizedString(@"V2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Hazelnut Pink
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdHazelnutPink;
    item.name = NSLocalizedString(@"V3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Beach Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBeachVintage;
    item.name = NSLocalizedString(@"V4", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Vintage Film
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdVintageFilm;
    item.name = NSLocalizedString(@"V5", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Dreamy Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdDreamyVintage;
    item.name = NSLocalizedString(@"V6", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Vivid Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdVividVintage;
    item.name = NSLocalizedString(@"V7", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Faerie Vintage
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFaerieVintage;
    item.name = NSLocalizedString(@"V8", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];

    //// Rusticana
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdCavalleriaRusticana;
    item.name = NSLocalizedString(@"V9", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
        
    //// Pink Bubble Tea
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdPinkBubbleTea;
    item.name = NSLocalizedString(@"P1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Gentle Memories
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGentleMemories;
    item.name = NSLocalizedString(@"P2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Rosey Matte
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdRoseyMatte;
    item.name = NSLocalizedString(@"P3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Walden Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdWaldenFaded;
    item.name = NSLocalizedString(@"F1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Amaro Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdAmaroFaded;
    item.name = NSLocalizedString(@"F2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Lanikai Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdLanikaiFaded;
    item.name = NSLocalizedString(@"F3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Frontpage Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFrontpageFaded;
    item.name = NSLocalizedString(@"F4", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Kodak Portra 800
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdKodakPortra800;
    item.name = NSLocalizedString(@"F5", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// PX 600
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdPx680;
    item.name = NSLocalizedString(@"F6", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Fuji Superia 800
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFujiSuperia800;
    item.name = NSLocalizedString(@"F7", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Qouzi Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdQouziFaded;
    item.name = NSLocalizedString(@"F8", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Fuji Superia 1600
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFujiSuperia1600;
    item.name = NSLocalizedString(@"F9", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Fresno Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFresnoFaded;
    item.name = NSLocalizedString(@"FV1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Deutan Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdDeutanFaded;
    item.name = NSLocalizedString(@"FV2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Brannan Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBrannanFaded;
    item.name = NSLocalizedString(@"FV3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Fixie Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFixieFaded;
    item.name = NSLocalizedString(@"FV4", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Breeze Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdLeningradFaded;
    item.name = NSLocalizedString(@"FV5", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Nashville Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdNashvilleFaded;
    item.name = NSLocalizedString(@"FV6", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// XPro 2 Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdXPro2Faded;
    item.name = NSLocalizedString(@"FV7", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// XPro 2 Faded
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGlamourBw;
    item.name = NSLocalizedString(@"BW1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Black White 20
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBlackWhite20;
    item.name = NSLocalizedString(@"BW2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Blur Berry
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBlueBerry;
    item.name = NSLocalizedString(@"CP1", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Donut
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdDonut;
    item.name = NSLocalizedString(@"CP2", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Sweet Flower
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdSweetFlower;
    item.name = NSLocalizedString(@"CP3", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Bluish Rose
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdBluishRose;
    item.name = NSLocalizedString(@"CP4", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Fruit Pop
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdFruitPop;
    item.name = NSLocalizedString(@"CP5", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Purple Berry
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdPurpleBerry;
    item.name = NSLocalizedString(@"CP6", nil);
    item.effectGroup = VnEffectGroupEffects;
    [_artisticFilters addObject:item];
    
    //// Green Apple
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdGreenApple;
    item.name = NSLocalizedString(@"CP7", nil);
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
    
    //// Velvet Color
    item = [[PtFtObjectFilterItem alloc] init];
    item.effectId = VnEffectIdVelvetColor;
    item.name = NSLocalizedString(@"H3", nil);
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
        case VnEffectIdDonut:
            return [VnEffectDonut new];
        case VnEffectIdPx680:
            return [VnEffectPx680 new];
        case VnEffectIdGirder:
            return [VnEffectGirder new];
        case VnEffectIdJoyful:
            return [VnEffectJoyful new];
        case VnEffectIdWeekend:
            return [VnEffectWeekend new];
        case VnEffectIdCarnival:
            return [VnEffectCarnival new];
        case VnEffectIdFruitPop:
            return [VnEffectFruitPop new];
        case VnEffectIdHazelnut:
            return [VnEffectHazelnut new];
        case VnEffectIdBlueBerry:
            return [VnEffectBlueBerry new];
        case VnEffectIdAmaroFaded:
            return [VnEffectAmaroFaded new];
        case VnEffectIdBluishRose:
            return [VnEffectBluishRose new];
        case VnEffectIdFixieFaded:
            return [VnEffectFixieFaded new];
        case VnEffectIdGreenApple:
            return [VnEffectGreenApple new];
        case VnEffectIdQouziFaded:
            return [VnEffectQouziFaded new];
        case VnEffectIdXPro2Faded:
            return [VnEffectXPro2Faded new];
        case VnEffectIdDeutanFaded:
            return [VnEffectDeutanFaded new];
        case VnEffectIdFresnoFaded:
            return [VnEffectFresnoFaded new];
        case VnEffectIdGentleColor:
            return [VnEffectGentleColor new];
        case VnEffectIdPurpleBerry:
            return [VnEffectPurpleBerry new];
        case VnEffectIdSweetFlower:
            return [VnEffectSweetFlower new];
        case VnEffectIdVelvetColor:
            return [VnEffectVelvetColor new];
        case VnEffectIdVividVintage:
            return [VnEffectVividVintage new];
        case VnEffectIdHappy:
            return [VnEffectHappy new];
        case VnEffectIdRoseyMatte:
            return [VnEffectRoseyMatte new];
        case VnEffectIdVintageHaze:
            return [VnEffectVintageHaze new];
        case VnEffectIdBlackWhite20:
            return [VnEffectBlackWhite20 new];
        case VnEffectIdSoftCream:
            return [VnEffectSoftCream new];
        case VnEffectIdVintageWine:
            return [VnEffectVintageWine new];
        case VnEffectIdVintageFilm:
            return [VnEffectVintageFilm new];
        case VnEffectIdVvintageSummer:
            return [VnEffectVintageSummer new];
        case VnEffectIdGlitterShine:
            return [VnEffectGlitterShine new];
        case VnEffectIdWaldenFaded:
            return [VnEffectWaldenFaded new];
        case VnEffectIdGlamourBw:
            return [VnEffectGlamourBw new];
        case VnEffectIdBrannanFaded:
            return [VnEffectBrannanFaded new];
        case VnEffectIdDreamyCreamy:
            return [VnEffectDreamyCreamy new];
        case VnEffectIdHazelnutPink:
            return [VnEffectHazelnutPink new];
        case VnEffectIdLanikaiFaded:
            return [VnEffectLanikaiFaded new];
        case VnEffectIdDreamyVintage:
            return [VnEffectDreamyVintage new];
        case VnEffectIdFaerieVintage:
            return [VnEffectFaerieVintage new];
        case VnEffectIdPinkBubbleTea:
            return [VnEffectPinkBubbleTea new];
        case VnEffectIdFrontpageFaded:
            return [VnEffectFrontpageFaded new];
        case VnEffectIdFujiSuperia800:
            return [VnEffectFujiSuperia800 new];
        case VnEffectIdGentleMemories:
            return [VnEffectGentleMemories new];
        case VnEffectIdKodakPortra800:
            return [VnEffectKodakPortra800 new];
        case VnEffectIdLeningradFaded:
            return [VnEffectLeningradFaded new];
        case VnEffectIdNashvilleFaded:
            return [VnEffectNashvilleFaded new];
        case VnEffectIdFujiSuperia1600:
            return [VnEffectFujiSuperia1600 new];
        case VnEffectIdCavalleriaRusticana:
            return [VnEffectCavalleriaRusticana new];
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
        effect.imageSize = image.size;
        [effect makeFilterGroup];
        if (opacity == 1.0f) {
            return [VnEffect processImage:image WithStartFilter:effect.startFilter EndFilter:effect.endFilter];
        }
        VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
        [inputFilter addTarget:effect.startFilter];
        VnImageNormalBlendFilter* outputFilter = [[VnImageNormalBlendFilter alloc] init];
        outputFilter.topLayerOpacity = opacity;
        [inputFilter addTarget:outputFilter];
        [effect.endFilter addTarget:outputFilter atTextureLocation:1];
        
        //// Added
        return [VnEffect processImage:image WithStartFilter:inputFilter EndFilter:outputFilter];
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
