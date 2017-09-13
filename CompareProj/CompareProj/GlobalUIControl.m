//
//  GlobalUIControl.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/13.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "GlobalUIControl.h"
static GlobalUIControl *sharedInstance;
@implementation GlobalUIControl
+ (GlobalUIControl*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalUIControl alloc] init];
    });
    return sharedInstance;
}
@end
