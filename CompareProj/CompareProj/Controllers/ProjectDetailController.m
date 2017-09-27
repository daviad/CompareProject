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
    NSString *_edittingKey;
    BOOL _isKeyEditting;
}
@property(nonatomic,strong)UITableView *contentTB;
@property(nonatomic,strong)Project *project;
@property(nonatomic,strong)Property *fakeProperty;
@property(nonatomic,strong)RLMResults<Property*> *sortProperties;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    
    self.title = self.project.name;
    _isEditting = NO;
    _edittingKey = @"";
    _contentTB = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _contentTB.delegate = self;
    _contentTB.dataSource = self;
    [self.view addSubview:_contentTB];
    [_contentTB registerClass:[ProjectDetailCell class] forCellReuseIdentifier:ReuseCellProjectDetailCell];
    [self createFooterView];
    
    self.sortProperties = self.project.sortProperties;
}

- (void)createFooterView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentTB.frame.size.width, 50)];
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    addBtn.layer.cornerRadius = 4;
    addBtn.clipsToBounds = YES;
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
    return 50;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak ProjectDetailController *weakSelf = self;
    NSMutableArray *resultArr = [NSMutableArray array];

//        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"eidt" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//            tableView.editing = NO;
//        }];
//        [resultArr addObject:action0];
 
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        Property *pro = [weakSelf.sortProperties objectAtIndex:indexPath.row];
        [weakSelf deleteProperty:pro];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        tableView.editing = NO;
    }];
    [resultArr addObject:action1];
    
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
    if (indexPath.row < self.project.sortProperties.count) {
      p = [self.sortProperties objectAtIndex:indexPath.row];
    }
    [cell setKey:p.name value:p.value];
    cell.editable = _isEditting;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.row >= _sortProperties.count || destinationIndexPath.row >= _sortProperties.count) {
        return;
    }
    if (sourceIndexPath.row != destinationIndexPath.row) {
        Property *sp = [self.sortProperties objectAtIndex:sourceIndexPath.row];
        Property *dp = [self.sortProperties objectAtIndex:destinationIndexPath.row];
        NSInteger sOrder = sp.order;
        NSInteger dOrder = dp.order;
        NSPredicate *sourcePred = [NSPredicate predicateWithFormat:@"classify.name == %@ and name == %@ ",self.project.classify.name, sp.name];
        RLMResults *sourcePros  = [Property objectsWithPredicate:sourcePred];
        NSPredicate *destPred = [NSPredicate predicateWithFormat:@"classify.name == %@ and name = %@ ",self.project.classify.name,dp.name];
        RLMResults *destPros = [Property objectsWithPredicate:destPred];
        
        Property *clsSPro = [[self.project.classify.rlmProperties objectsWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",sp.name]] firstObject];
        Property *clsDPro = [[self.project.classify.rlmProperties objectsWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",dp.name]] firstObject];
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            for (Property *pro in sourcePros) {
                pro.order = dOrder;
            }
            for (Property *pro in destPros) {
                pro.order = sOrder;
            }
            clsSPro.order = dOrder;
            clsDPro.order = sOrder;
        }];
    }
}

#pragma mark- ProjectDetailCellDelegate
- (void)keyBeginEdit:(ProjectDetailCell *)cell text:(NSString *)text
{
    _isKeyEditting = YES;
    _contentTB.tableFooterView.hidden = YES;
}

- (void)keyEditDone:(ProjectDetailCell*)cell text:(NSString*)text
{
    _isKeyEditting = NO;
    
    if (text.length > 0) {
        NSIndexPath *index = [_contentTB indexPathForCell:cell];
        if (index.row < self.project.rlmProperties.count) {
            Property *p = self.project.rlmProperties[index.row];
            if (![text isEqualToString:p.name]) {
                [self freshPropertyNameWith:p.name newName:text];
            }
        } else {
            if (_fakeProperty) {
                [self addPropertyNameWithProperty:text];
            } else {
                
            }
        }
        _contentTB.tableFooterView.hidden = NO;
    }
//    _edittingKey = @"";
    
}

- (void)valueEditDone:(ProjectDetailCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        NSIndexPath *index = [_contentTB indexPathForCell:cell];
        if (index.row < self.project.rlmProperties.count) {
            Property *p = self.project.rlmProperties[index.row];
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                p.value = text;
            }];
        }
        else {
            if (_fakeProperty) {
                _fakeProperty.value = text;
                if ([_fakeProperty.name isEqualToString:@""]) {
                } else {
                    [[RLMRealm defaultRealm] transactionWithBlock:^{
                        [self.project.rlmProperties addObject:_fakeProperty];
                    }];
                    _fakeProperty = nil;
                }
            }
        }
    }
}
- (void)keyDidChange:(ProjectDetailCell *)cell text:(NSString *)text
{
    _edittingKey = text;
}
#pragma mark- event
- (void)toggleEditStatus
{
    if (_fakeProperty && [_edittingKey isEqualToString:@""]) {
        _fakeProperty = nil;
        [_contentTB beginUpdates];
        [_contentTB deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.project.rlmProperties.count inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [_contentTB endUpdates];
    }
    _isEditting = !_isEditting;
    [self changeEditStatus];
    [_contentTB reloadData];
}

- (void)addItem
{
    if (!_isEditting) {
        _isEditting = YES;
        [self changeEditStatus];
    }
    if ([self keyIsExist:[_edittingKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {

    } else {
        if (_fakeProperty) {
            [self addPropertyNameWithProperty:_edittingKey];
        }
        _fakeProperty = [[Property alloc] init];
        _edittingKey = @"";
        _fakeProperty.classify = self.project.classify;
        Property *maxOderProperty = [self.project.classify.sortPoperties lastObject];
        _fakeProperty.order = maxOderProperty.order + 1;   //当创建property的数量太多越界，程序失败。但是，这种情况现实这不会出现。
        
//        [_contentTB beginUpdates];
//        [_contentTB insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.project.rlmProperties.count inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [_contentTB endUpdates];
        [_contentTB reloadData];
    }
}

#pragma mark- utils
- (void)changeEditStatus
{
    [self changeNavigatinonRightItem];
    [_contentTB setEditing:_isEditting animated:YES];
    
}
- (void)changeNavigatinonRightItem
{
    if (_isEditting)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
}

- (BOOL)keyIsExist:(NSString*)name
{
//    NSArray *names = self.project.properties;
    return(_fakeProperty && [_edittingKey isEqualToString:@""]);
}

- (void)addPropertyNameWithProperty:(NSString*)text
{
    _fakeProperty.name = text;
    
    if (![self.project.properties containsObject:text]) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [self.project.rlmProperties addObject:_fakeProperty];
        }];
        
        Property *pro = [[self.project.classify.rlmProperties objectsWithPredicate:[NSPredicate predicateWithFormat:@"name == %@ ",text]] firstObject];
        if (pro) {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                pro.count ++;
            }];
            [self addOtherDBPropertyIsNewProperty:NO withClassifyProperty:nil];
        } else {
            Property *newProperty = [_fakeProperty customCopy];
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [self.project.classify.rlmProperties addObject:newProperty];
            }];
            [self addOtherDBPropertyIsNewProperty:YES withClassifyProperty:newProperty];
        }
        
        _fakeProperty = nil;
    }

}
- (void)addOtherDBPropertyIsNewProperty:(BOOL)flag withClassifyProperty:(Property*)cpro
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"classify.name == %@ and name != %@ ",self.project.classify.name,self.project.name];
    RLMResults *ps  = [Project objectsWithPredicate:pred];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for (Project *p in ps) {
            if (flag) {
                [p.rlmProperties addObject:[_fakeProperty customCopy]];
                cpro.count ++;
            } else if ([[p.rlmProperties objectsWithPredicate:[NSPredicate predicateWithFormat:@"name == %@ ",_fakeProperty.name]] count] == 0) {
                [p.rlmProperties addObject:[_fakeProperty customCopy]];
                cpro.count ++;
            }
        }
    }];
}

- (void)freshPropertyNameWith:(NSString*)oldName newName:(NSString*)newName
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"classify.name == %@ and name == %@  ",self.project.classify.name, oldName];
    RLMResults *pros  = [Property objectsWithPredicate:pred];
    for (Property *pro in pros) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            pro.name = newName;
        }];
    }
}

- (void)deleteProperty:(Property*)pro
{
    Property *classifyPro = [[self.project.classify.rlmProperties objectsWithPredicate:[NSPredicate predicateWithFormat:@"name == %@",pro.name]] firstObject];
    NSAssert(classifyPro, @"classifyPro == nil");
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObject:pro];
        if (classifyPro.count == 1) {
            [[RLMRealm defaultRealm] deleteObject:classifyPro];
        } else {
            classifyPro.count --;
        }
    }];
}
@end
