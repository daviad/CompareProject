//
//  RLMRealm+AGDynamic.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

// extracted from RLMRealm_Dynamic.h
@interface RLMRealm (AGDynamic)
+ (instancetype)realmWithPath:(NSString *)path
                          key:(NSData *)key
                     readOnly:(BOOL)readonly
                     inMemory:(BOOL)inMemory
                      dynamic:(BOOL)dynamic
                       schema:(RLMSchema *)customSchema
                        error:(NSError **)outError;

- (RLMResults *)allObjects:(NSString *)className;
- (RLMObject *)createObject:(NSString *)className withValue:(id)value;
@end

@interface RLMProperty (AGDynamic)
- (instancetype)initWithName:(NSString *)name
                        type:(RLMPropertyType)type
             objectClassName:(NSString *)objectClassName
                     indexed:(BOOL)indexed;
@end

@interface RLMObjectSchema (AGDynamic)
- (instancetype)initWithClassName:(NSString *)objectClassName objectClass:(Class)objectClass properties:(NSArray *)properties;
@end

// extracted from RLMSchema_Private.h
@interface RLMSchema (AGDynamic)
@property (nonatomic, readwrite, copy) NSArray *objectSchema;
@end
