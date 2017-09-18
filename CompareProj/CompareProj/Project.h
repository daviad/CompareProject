//
//  Project.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Property.h"

RLM_ARRAY_TYPE(Project);

@interface Project :  RLMObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger order;
@property(nonatomic,strong)NSMutableArray<NSString*> *properties;
@property RLMArray<Property *><Property> *rlmProperties;
@end
