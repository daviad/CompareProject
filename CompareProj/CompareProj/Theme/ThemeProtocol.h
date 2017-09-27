//
//  ThemeProtocol.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/27.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>
@protocol ThemeProtocol <NSObject>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong,readonly)UIColor *tintColor;
//Lable
@property(nonatomic,strong,readonly)UIColor *textColor;
//Button
@property(nonatomic,strong,readonly)UIColor *buttonBackgroudColor;
@property(nonatomic,strong,readonly)UIColor *buttonTiltleColor;
@property(nonatomic,strong,readonly)UIFont *buttonFont;

@end
