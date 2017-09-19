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
    return @{@"uuid":[[NSUUID UUID] UUIDString],@"value":@""};
}

- (Property*)customCopy
{
    Property *proNew = [[Property alloc] init];
    proNew.name = self.name;
    proNew.order = self.order;
    return proNew;
}
@end
