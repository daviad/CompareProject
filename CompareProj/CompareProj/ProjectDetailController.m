//
//  ProjectContentController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ProjectDetailController.h"
#import "ProjectDetailCell.h"
#import "Property.h"

@interface ProjectDetailController ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailCellDelegate>
{
    BOOL _isEditting;
}
@property(nonatomic,strong)UITableView *contentTB;
//@property(nonatomic,strong)NSMutableArray *properties;
@property(nonatomic,strong)Project *project;

@end

@implementation ProjectDetailController

- (instancetype)initWithProject:(Project*)p
{
    if (self = [super init]) {
        self.project = p;
//        self.properties = p.properties;
    }
    return self;
}

#define ReuseCellProjectDetailCell   @"ProjectDetailCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    
    self.title = self.project.name;
    _isEditting = NO;
    _contentTB = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _contentTB.delegate = self;
    _contentTB.dataSource = self;
    [self.view addSubview:_contentTB];
    [_contentTB registerClass:[ProjectDetailCell class] forCellReuseIdentifier:ReuseCellProjectDetailCell];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_contentTB.frame.size.width/2, 0, 1, self.view.frame.size.height)];
    line.backgroundColor = [UIColor grayColor];
    [_contentTB addSubview:line];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    __weak ProjectDetailController *weakSelf = self;
    NSMutableArray *resultArr = [NSMutableArray array];

        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"eidt" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"");
            tableView.editing = NO;
        }];
        [resultArr addObject:action0];
 
    
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        [weakSelf.project.rlmProperties removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        tableView.editing = NO;
//    }];
//    [resultArr addObject:action1];
    
    return resultArr;
}
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    
//}
#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.project.rlmProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellProjectDetailCell];
    Property *p = [self.project.rlmProperties objectAtIndex:indexPath.row];
    [cell setKey:p.name value:p.value];
    cell.editable = _isEditting;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Property *sp = [self.project.rlmProperties objectAtIndex:sourceIndexPath.row];
    Property *dp = [self.project.rlmProperties objectAtIndex:destinationIndexPath.row];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        sp.order = destinationIndexPath.row;
        dp.order = sourceIndexPath.row;
    }];
}

#pragma mark- ProjectDetailCellDelegate
- (void)keyEditDone:(ProjectDetailCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        NSIndexPath *index = [_contentTB indexPathForCell:cell];
        Property *p = self.project.rlmProperties[index.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            p.name = text;
        }];
    }
}
- (void)valueEditDone:(ProjectDetailCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        NSIndexPath *index = [_contentTB indexPathForCell:cell];
        Property *p = self.project.rlmProperties[index.row];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            p.value = text;
        }];
    }
}

//- (void)editProperty:(Property*)p withName:(NSString*)n withValue:(NSString*)v
//{
//    NSMutableArray *originArr = [NSMutableArray array];
//    for (Property *pro in self.project.rlmProperties) {
//        if (n) {
//            [originArr addObject:pro.name];
//        }
//        else
//        {
//            [originArr addObject:pro.value];
//        }
//    }
//
//    NSString *tempStr = n?n:v;
//    if ([originArr containsObject:tempStr])
//    {
//        if (n) {
//            p.name = n;
//        }
//        else
//        {
//            p.value = v;
//        }
//    }
//    else
//    {
//        NSLog(@"please new item");
//    }
//
//}
#pragma mark- event
- (void)toggleEditStatus
{
    _isEditting = !_isEditting;
    [self editTableView];
}
- (void)editTableView
{
    
    if (_isEditting)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
    [_contentTB setEditing:_isEditting animated:YES];
    [_contentTB reloadData];
}

@end
