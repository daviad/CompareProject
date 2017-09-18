//
//  ProjectClassify.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ProjectClassify.h"

@implementation ProjectClassify
+ (NSString*)primaryKey
{
    return @"uuid";
}

+ (nullable NSDictionary *)defaultPropertyValues
{
    return @{@"uuid":[[NSUUID UUID] UUIDString]};
}

+ (NSArray *)ignoredProperties {
    return @[@"properties"];
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
