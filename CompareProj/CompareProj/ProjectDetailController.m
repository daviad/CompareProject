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
#import "ProjectClassify.h"

@interface ProjectDetailController ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailCellDelegate>
{
    BOOL _isEditting;
}
@property(nonatomic,strong)UITableView *contentTB;
@property(nonatomic,strong)Project *project;
@property(nonatomic,strong)Property *fakeProperty;

@end

@implementation ProjectDetailController

- (instancetype)initWithProject:(Project*)p
{
    if (self = [super init]) {
        self.project = p;
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
    [self createFooterView];
}

- (void)createFooterView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentTB.frame.size.width, 50)];
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"add" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor blueColor];
    addBtn.frame = CGRectMake((_contentTB.frame.size.width/2 - 80/2), 3, 80, 44);
    [footView addSubview:addBtn];
    _contentTB.tableFooterView = footView;
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

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fakeProperty ? (self.project.rlmProperties.count + 1) : self.project.rlmProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellProjectDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Property *p = _fakeProperty;
    if (indexPath.row < self.project.rlmProperties.count) {
      p = [self.project.rlmProperties objectAtIndex:indexPath.row];
    }
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
        if (_fakeProperty) {
            _fakeProperty.name = text;
            if (![self.project.properties containsObject:text]) {
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    [self.project.rlmProperties addObject:_fakeProperty];
                }];
            }
            
            if (![self.project.classify.properties containsObject:text]) {
                [self addAllDBProperty];
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    [self.project.classify.rlmProperties addObject:_fakeProperty];
                }];
            }
            _fakeProperty = nil;
        } else {
            NSIndexPath *index = [_contentTB indexPathForCell:cell];
            Property *p = self.project.rlmProperties[index.row];
            if (![text isEqualToString:p.name]) {
                [self freshPropertyNameWith:p.name newName:text];
            }
        }
    }
}
- (void)addAllDBProperty
{
    RLMResults *ps = [[Project allObjects] objectsWhere:[NSString stringWithFormat:@"name = %@",self.project.name]];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for (Project *p in ps) {
            [p.rlmProperties addObject:_fakeProperty];
        }
    }];
}
- (void)freshPropertyNameWith:(NSString*)oldName newName:(NSString*)newName
{
    //此处 查询可以 级联么？
   RLMResults *ps = [[Project allObjects] objectsWhere:[NSString stringWithFormat:@"name = %@",self.project.name]];
    for (Project *p in ps) {
        RLMResults *pros = [p.rlmProperties objectsWhere:[NSString stringWithFormat:@"name = %@",oldName]];
        for (Property *pro in pros) {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                pro.name = newName;
            }];
        }
    }
}
- (void)valueEditDone:(ProjectDetailCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        if (_fakeProperty) {
            _fakeProperty.value = text;
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [self.project.rlmProperties addObject:_fakeProperty];
            }];
            _fakeProperty = nil;
        } else {
            NSIndexPath *index = [_contentTB indexPathForCell:cell];
            Property *p = self.project.rlmProperties[index.row];
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                p.value = text;
            }];
        }
    }
}

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

- (void)addItem
{
    _fakeProperty = [[Property alloc] init];
    [_contentTB beginUpdates];
    [_contentTB insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.project.rlmProperties.count inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [_contentTB endUpdates];
}
@end
