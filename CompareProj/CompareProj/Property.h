//
//  Property.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/13.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Realm/Realm.h>
RLM_ARRAY_TYPE(Property);
//@class Project;
@interface Property : RLMObject
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *value;
//@property(nonatomic,strong)Project *project;
@property(nonatomic,assign)NSInteger order;
@end
