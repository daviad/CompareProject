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
@property(nonatomic,strong)Project *project;
@end

@implementation PropertyController

- (instancetype)initWithPoject:(Project*)p
{
    if (self = [super init]) {
        _project = p;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.title = @"Property";
    self.view.backgroundColor = [UIColor whiteColor];
    
    EditController *childCtr = [[EditController alloc] initWithDataArr:_project.properties];
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
- (void)clickEditDetail
{
    
}

- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)addItem:(NSString *)text atIndex:(NSInteger)index
{
    Property *property = [[Property alloc] init];
    property.uuid = [[NSUUID UUID] UUIDString];
    property.name = text;
    __weak Project *weakProj = _project;
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [weakProj.rlmProperties addObject:property];
    }];
}
@end
