//
//  Project.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "Project.h"

@implementation Project
+ (NSArray *)ignoredProperties {
    return @[@"properties"];
}

+ (NSString *)primaryKey {
    return @"name";
}

- (NSMutableArray*)properties
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:self.rlmProperties.count];
    for (Property *p in self.rlmProperties) {
        [tempArr addObject:p.name];
    }
    return tempArr;
}
@end
