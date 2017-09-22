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
    return @[@"properties",@"sortPoperties",@"sortProjects"];
}

- (NSMutableArray*)properties
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:self.sortPoperties.count];
    for (Property *p in self.sortPoperties) {
        [tempArr addObject:p.name];
    }
    return tempArr;
}

- (RLMResults*)sortPoperties
{
    if (!_sortPoperties) {
        _sortPoperties = [self.rlmProperties sortedResultsUsingKeyPath:@"order" ascending:YES];
    }
    return _sortPoperties;
}

- (RLMResults*)sortProjects
{
    if (!_sortProjects) {
        _sortProjects = [self.rlmProjects sortedResultsUsingKeyPath:@"order" ascending:YES];
    }
    return _sortProjects;
}
@end
