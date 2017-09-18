//
//  ClassifyController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ClassifyController.h"
#import "EditController.h"
#import <Realm/Realm.h>
#import "ProjectClassify.h"
#import "ProjectController.h"
#import "PropertyController.h"

@interface ClassifyController ()<EditControllerDelegate>
@property(nonatomic,strong)RLMResults *classifies;
//@property(nonatomic,strong)ProjectClassify *classify;
@end

@implementation ClassifyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"classify list";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _classifies = [[ProjectClassify allObjects] sortedResultsUsingKeyPath:@"order" ascending:YES];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:_classifies.count];
    for (ProjectClassify *c in _classifies) {
        [tempArr addObject:c.name];
    }
    EditController *childCtr = [[EditController alloc] initWithDataArr:tempArr];
    [self addChildViewController:childCtr];
    childCtr.delegate = self;
    [self.view addSubview:childCtr.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- EditControllerDelegate
- (void)jumpToDetailControllerWithIndex:(NSInteger)index
{
    ProjectClassify *pc = _classifies[index];
    [self.navigationController pushViewController:[[ProjectController alloc] initWithClassify:pc] animated:YES];
}

- (BOOL)needEidtDetail
{
    return YES;
}
- (void)clickEditDetailAtIndexPath:(NSIndexPath*)indexPath;
{
    ProjectClassify *pc = _classifies[indexPath.row];
    [self.navigationController pushViewController:[[PropertyController alloc] initWithPojectClassify:pc] animated:YES];

}

- (void)deleteRowsAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _classifies.count)
    {
        ProjectClassify *p = [_classifies objectAtIndex:indexPath.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] deleteObject:p];
        }];
    }

}
- (void)editItem:(NSString *)text atIndex:(NSInteger)index
{
    ProjectClassify *p = nil;
    if (index == _classifies.count)
    {
        p = [[ProjectClassify alloc] init];
        p.name = text;
        p.order = index;
    }
    else
    {
        p = [_classifies objectAtIndex:index];
    }
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObject:p];
    }];
}

- (void)editController:(EditController *)ctr moveRowAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex
{
    ProjectClassify *sp = [_classifies objectAtIndex:sourceIndex];
    ProjectClassify *dp = [_classifies objectAtIndex:destinationIndex];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        sp.order = destinationIndex;
        dp.order = sourceIndex;
    }];
    
}
- (void)compare
{
    
}
@end
