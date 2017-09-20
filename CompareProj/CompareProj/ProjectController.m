//
//  EditProjControllerViewController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ProjectController.h"
#import "PropertyController.h"
#import "EditController.h"
#import "GlobalUIControl.h"
#import <Realm/Realm.h>
#import "Project.h"
#import "ProjectDetailController.h"
#import "CompareController.h"

@interface ProjectController ()<EditControllerDelegate>
{

}
@property(nonatomic,strong)RLMResults *projects;
@property(nonatomic,strong)ProjectClassify *projectClassify;
@end

@implementation ProjectController
- (instancetype)initWithClassify:(ProjectClassify *)pc
{
    if (self = [super init]) {
        self.projectClassify = pc;
        _projects = [self.projectClassify.rlmProjects sortedResultsUsingKeyPath:@"order" ascending:YES];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.projectClassify.name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:_projects.count];
    for (Project *p in _projects) {
        [tempArr addObject:p.name];
    }
    EditController *childCtr = [[EditController alloc] initWithDataArr:tempArr];
    [self addChildViewController:childCtr];
    childCtr.delegate = self;
    childCtr.needCompare = YES;
    [self.view addSubview:childCtr.view];
}

#pragma mark- EditControllerDelegate
- (void)jumpToDetailControllerWithIndex:(NSInteger)index
{
    Project *p = _projects[index];
    [self.navigationController pushViewController:[[ProjectDetailController alloc] initWithProject:p] animated:YES];
}

- (BOOL)needEidtDetail
{
    return NO;
}
- (void)clickEditDetailAtIndexPath:(NSIndexPath*)indexPath;
{
    Project *p = _projects[indexPath.row];
    [self.navigationController pushViewController:[[PropertyController alloc] initWithPoject:p] animated:YES];
}

- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _projects.count)
    {
        Project *p = [_projects objectAtIndex:indexPath.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] deleteObject:p];
        }];
    }

}
- (void)editItem:(NSString *)text atIndex:(NSInteger)index
{
    Project *p = nil;
    if (_projects.count == index) {
        p = [[Project alloc] init];
        p.name = text;
        p.order = index;
        NSMutableArray *pros = [NSMutableArray array];
        for (Property *pro in self.projectClassify.rlmProperties) {
            [pros addObject:[pro customCopy]];
        }
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [p.rlmProperties addObjects:pros];
            p.classify = self.projectClassify;
            [self.projectClassify.rlmProjects addObject:p];
        }];
    }
    else
    {
        p = [_projects objectAtIndex:index];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObject:p];
        }];
    }

}

- (void)editController:(EditController *)ctr moveRowAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex
{
    Project *sp = [_projects objectAtIndex:sourceIndex];
    Project *dp = [_projects objectAtIndex:destinationIndex];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        sp.order = destinationIndex;
        dp.order = sourceIndex;
    }];

}

- (void)compare
{

    CompareController *ctr = [[CompareController alloc] initWithClassify:self.projectClassify];
    [self.navigationController pushViewController:ctr animated:YES];
}
#pragma uitls
- (void)refreshData
{
}
@end
