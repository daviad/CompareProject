//
//  PropertyController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "PropertyController.h"
#import "EditController.h"
#import <Realm/Realm.h>
@interface PropertyController ()<EditControllerDelegate>
{
    
}
@property(nonatomic,strong)ProjectClassify *classify;
@end

@implementation PropertyController

- (instancetype)initWithPoject:(Project*)p
{
//    if (self = [super init]) {
//        _project = p;
//    }
    return self;
}
- (instancetype)initWithPojectClassify:(ProjectClassify*)pc;
{
    if (self = [super init]) {
        _classify = pc;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.title = @"Property";
    self.view.backgroundColor = [UIColor whiteColor];
    
    EditController *childCtr = [[EditController alloc] initWithDataArr:_classify.properties];
    [self addChildViewController:childCtr];
    childCtr.delegate = self;
    [self.view addSubview:childCtr.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
#pragma mark- EditControllerDelegate
- (void)jumpToDetailControllerWithIndex:(NSInteger)index
{
}
- (BOOL)needEidtDetail
{
    return NO;
}
- (void)clickEditDetailAtIndexPath:(NSIndexPath*)indexPath;
{
    
}

- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _classify.rlmProperties.count)
    {
        Property *p = [_classify.rlmProperties objectAtIndex:indexPath.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] deleteObject:p];
        }];
    }
}
- (void)editItem:(NSString *)text atIndex:(NSInteger)index
{
    Property *property = nil;
    if (_classify.rlmProperties.count == index) {
        property = [[Property alloc] init];
        property.uuid = [[NSUUID UUID] UUIDString];
        property.name = text;
        __weak ProjectClassify *weakProj = _classify;
        [[RLMRealm defaultRealm] transactionWithBlock:^{
          [weakProj.rlmProperties addObject:property];
        }];
    }
    else
    {
        property = [_classify.rlmProperties objectAtIndex:index];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObject:property];
        }];
    }
}
- (void)editController:(EditController *)ctr moveRowAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex
{
    
}

- (void)compare
{
    
}
@end
