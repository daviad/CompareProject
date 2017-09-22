//
//  Property.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/13.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "Property.h"

@implementation Property
+ (NSString*)primaryKey
{
    return @"uuid";
}

+ (NSDictionary*)defaultPropertyValues
{
    return @{@"uuid":[[NSUUID UUID] UUIDString],@"name":@"",@"value":@"",@"count":@"1"};
}

- (Property*)customCopy
{
    Property *proNew = [[Property alloc] init];
    proNew.name = self.name;
    proNew.order = self.order;
    proNew.classify = self.classify;
    return proNew;
}
@end
