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
    return @[@"properties",@"sortProperties"];
}

+ (NSString *)primaryKey {
    return @"name";
}

- (NSMutableArray*)properties
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:self.sortProperties.count];
    for (Property *pro in self.sortProperties) {
        [tempArr addObject:pro.name];
    }
    return tempArr;
}

- (RLMResults*)sortProperties
{
    if (!_sortProperties) {
        _sortProperties = [self.rlmProperties sortedResultsUsingKeyPath:@"order" ascending:YES];
    }
    return _sortProperties;
}
@end
