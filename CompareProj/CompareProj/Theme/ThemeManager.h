//
//  ThemeManager.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/27.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeProtocol.h"

#define CurrentTheme  [ThemeManager sharedInstance].currentTheme

@interface ThemeManager : NSObject
+ (ThemeManager*)sharedInstance;
@property id<ThemeProtocol>currentTheme;
@end

