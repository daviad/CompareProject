//
//  ThemeManager.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/27.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ThemeManager.h"
@implementation ThemeManager
static ThemeManager *sharedInstance;
+ (ThemeManager*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ThemeManager alloc] init];
        [sharedInstance loadThemeWhithClassName:@"DefaultTheme"];
    });
    return sharedInstance;
}

- (void)loadThemeWhithClassName:(NSString*)cls {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincompatible-pointer-types"
    id<ThemeProtocol>theme = [[NSClassFromString(cls) alloc] init];
#pragma clang diagnostic pop
    [self loadTheme:theme];
}
- (void)loadTheme:(id<ThemeProtocol>) theme{
    self.currentTheme = theme;
    
    UIWindow.appearance.tintColor = theme.tintColor;
    //button
    [UIButton.appearance setTitleColor:theme.buttonTiltleColor forState:UIControlStateNormal];
    
}
@end
