//
//  GlobalUIControl.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/13.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GlobalUIControl : NSObject
+ (GlobalUIControl*)sharedInstance;
@property(nonatomic,strong)UINavigationController* navigationController;
@property(nonatomic,strong)UINavigationItem *navigationItem;
@end
