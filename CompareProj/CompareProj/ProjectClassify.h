//
//  ProjectClassify.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Realm/Realm.h>
#import "Project.h"
@interface ProjectClassify : RLMObject
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger order;
@property(nonatomic,strong)NSMutableArray<NSString*> *properties;
@property RLMArray<Project *><Project> *rlmProjects;
@property RLMArray<Property *><Property> *rlmProperties;
@property(nonatomic,strong)RLMResults *sortPoperties;
@end
