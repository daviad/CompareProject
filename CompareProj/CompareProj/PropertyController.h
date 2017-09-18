//
//  PropertyController.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "ProjectClassify.h"
@interface PropertyController : UIViewController
- (instancetype)initWithPoject:(Project*)p;
- (instancetype)initWithPojectClassify:(ProjectClassify*)pc;
@end
