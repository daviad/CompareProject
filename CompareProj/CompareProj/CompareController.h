//
//  CompareController.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "ProjectClassify.h"
@interface CompareController : UIViewController
- (instancetype)initWithProjects:(NSArray<Project*> *)pjs;
- (instancetype)initWithClassify:(ProjectClassify *)pc;

@end
