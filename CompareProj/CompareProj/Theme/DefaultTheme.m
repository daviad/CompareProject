//
//  DefaultTheme.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/27.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "DefaultTheme.h"

@implementation DefaultTheme
- (instancetype)init {
    if (self = [super init]) {
        _name = @"default";
        _tintColor = nil;
        _textColor = nil;
        
        //button
        _buttonBackgroudColor = [UIColor lightGrayColor];
        _buttonTiltleColor = [UIColor whiteColor];
        _buttonFont = nil;

    }
    return self;
}

@end
