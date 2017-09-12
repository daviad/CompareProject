//
//  RLMRealm+AGDynamic.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "RLMRealm+AGDynamic.h"




//// also see realm dynamic tests
//// https://github.com/realm/realm-cocoa/blob/123f97cdb2819397e289e088558f36e365e712a7/Realm/Tests/DynamicTests.m
//- (void)testDynamic {
//    [RLMRealm setSchemaVersion:1 forRealmAtPath:RLMTestRealmPath() withMigrationBlock:^(RLMMigration *migration, NSUInteger oldSchemaVersion) {
//    }];
//
//    RLMProperty *propA = [[RLMProperty alloc] initWithName:@"uuid" type:RLMPropertyTypeString objectClassName:nil indexed:YES];
//    RLMProperty *propB = [[RLMProperty alloc] initWithName:@"title" type:RLMPropertyTypeString objectClassName:nil indexed:NO];
//    RLMObjectSchema *objectSchema = [[RLMObjectSchema alloc] initWithClassName:@"TrulyDynamicObject" objectClass:RLMObject.class properties:@[propA, propB]];
//    RLMSchema *schema = [[RLMSchema alloc] init]; // it would be great to have RLMSchema method like +schemaWithClassName:objectClass:properties
//    schema.objectSchema = @[objectSchema];
//
//    RLMRealm *dyrealm = [RLMRealm realmWithPath:RLMTestRealmPath() key:nil readOnly:NO inMemory:NO dynamic:YES schema:schema error:nil];
//
//    [dyrealm beginWriteTransaction];
//    [dyrealm createObject:@"TrulyDynamicObject" withValue:@{@"uuid": [[NSUUID UUID] UUIDString], @"title": @"item title"}];
//    [dyrealm commitWriteTransaction];
//
//    RLMResults *results = [dyrealm allObjects:@"TrulyDynamicObject"];
//    for (id obj in results) {
//        NSLog(@"%@ %@", obj[@"uuid"], obj[@"title"]);
//    }
//}

