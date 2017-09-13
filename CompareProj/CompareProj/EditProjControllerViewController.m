//
//  EditProjControllerViewController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "EditProjControllerViewController.h"
#import "PropertyController.h"
#import "EditController.h"
#import "GlobalUIControl.h"
#import <Realm/Realm.h>
#import "Project.h"

@interface EditProjControllerViewController ()<EditControllerDelegate>
{

}
@property(nonatomic,strong)RLMResults *projects;
@end

@implementation EditProjControllerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"projec list";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _projects = [[Project allObjects] sortedResultsUsingKeyPath:@"order" ascending:YES];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:_projects.count];
    for (Project *p in _projects) {
        [tempArr addObject:p.name];
    }
    EditController *childCtr = [[EditController alloc] initWithDataArr:tempArr];
    [self addChildViewController:childCtr];
    childCtr.delegate = self;
    [self.view addSubview:childCtr.view];
}

#pragma mark- EditControllerDelegate
- (void)jumpToDetailControllerWithIndex:(NSInteger)index
{
    Project *p = _projects[index];
    [self.navigationController pushViewController:[[PropertyController alloc] initWithPoject:p] animated:YES];
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
    Project *p = [_projects objectAtIndex:indexPath.row];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObject:p];
    }];
}
- (void)addItem:(NSString *)text atIndex:(NSInteger)index
{
    Project *p = [[Project alloc] init];
    p.name = text;
    p.order = index;
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addObject:p];
    }];
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
@end
