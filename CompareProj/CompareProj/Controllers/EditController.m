//
//  EditController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "EditController.h"
#import "EditableCell.h"
#import "GlobalUIControl.h"

@interface EditController ()<UITableViewDelegate,UITableViewDataSource,EditableCellDelegate>
{
    UITableView *_tableView;
    BOOL _isEditting;
    NSString *_editingText;
}
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation EditController

- (instancetype)initWithDataArr:(NSMutableArray *)arr
{
    if (self = [super init]) {
        _dataArr = arr;
    }
    return self;
}

#define  ReuseCell   @"ReuseCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    _isEditting = NO;
    _editingText = @"";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[EditableCell class] forCellReuseIdentifier:ReuseCell];
    [self creatTableFootView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatTableFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 50)];
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = CurrentTheme.buttonBackgroudColor;
    addBtn.layer.cornerRadius = 4;
    addBtn.clipsToBounds = YES;
   
    UIButton *compareBtn = [[UIButton alloc] init];
    [compareBtn setTitle:@"对比" forState:UIControlStateNormal];
    [compareBtn addTarget:self action:@selector(compare) forControlEvents:UIControlEventTouchUpInside];
   compareBtn.backgroundColor = CurrentTheme.buttonBackgroudColor;
    compareBtn.layer.cornerRadius = 4;
    compareBtn.clipsToBounds = YES;
    
    if (self.needCompare && _dataArr.count > 1) {
        addBtn.frame = CGRectMake((_tableView.frame.size.width/4 - 80/2), 3, 80, 44);
        compareBtn.frame = CGRectMake((_tableView.frame.size.width/2 + 80/2), 9, 80, 44);
        [footView addSubview:addBtn];
        [footView addSubview:compareBtn];
    } else {
        addBtn.frame = CGRectMake((_tableView.frame.size.width/2 - 80/2), 3, 80, 44);
        [footView addSubview:addBtn];
    }
    _tableView.tableFooterView = footView;
}
#pragma mark- @protocol UITableViewDataSource<NSObject>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    cell.text = _dataArr[indexPath.row];
    cell.editable = _isEditting;
    cell.delegate = self;
    return cell;
}


// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// Data manipulation - reorder / moving support
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_dataArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [self.delegate editController:self moveRowAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark--  UITableViewDelegate<NSObject, UIScrollViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [_dataArr objectAtIndex:indexPath.row];
    if (str.length > 0) {
        [self.delegate jumpToDetailControllerWithIndex:indexPath.row];
    }
    else
    {
        
    }
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak EditController *weakSelf = self;
    NSMutableArray *resultArr = [NSMutableArray array];
//    if ([self.delegate needEidtDetail]) {
//        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"eidt" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//            NSLog(@"");
//            [weakSelf.delegate clickEditDetailAtIndexPath:indexPath];
//            tableView.editing = NO;
//        }];
//        [resultArr addObject:action0];
//    }

    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakSelf.delegate deleteRowsAtIndexPath:indexPath];
        [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        tableView.editing = NO;
    }];
    [resultArr addObject:action1];
    
    return resultArr;
}

#pragma mark-- evnet
- (void)toggleEditStatus
{
    _isEditting = !_isEditting;
    [self changeEditStatus];
    [_tableView reloadData];
    _editingText = @"";

}
- (void)addItem
{
    if ([self nameIsExist:[_editingText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
    } else {
        [_dataArr addObject:@""];
        _isEditting = YES;
        [self changeEditStatus];
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataArr.count -1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [_tableView endUpdates];
    }
}

- (void)compare
{
    [self.delegate compare];
}

#pragma mark-  EditableCellDelegate <NSObject>
- (void)textEditDone:(EditableCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        if ([self nameIsExist:_editingText]) {
            [_dataArr removeLastObject];
            [_tableView beginUpdates];
            [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataArr.count inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
            [_tableView endUpdates];
        }
        if ([self nameIsExist:text])
        {
            NSLog(@"please new item");
        }
        else
        {
            NSIndexPath *index = [_tableView indexPathForCell:cell];
            [_dataArr replaceObjectAtIndex:index.row withObject:text];
            [self.delegate editItem:text atIndex:index.row];
            
            if (_dataArr.count == 2) {
                [self creatTableFootView];
            }
        }

    }
    else
    {
        [_dataArr removeLastObject];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataArr.count inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [_tableView endUpdates];
    }
   
}

- (void)textDidChange:(EditableCell *)cell tex:(NSString *)text
{
    _editingText = text;
}
#pragma mak- utils
- (void)changeEditStatus
{
    [self changeNavigatinonRightItem];
    [_tableView setEditing:_isEditting animated:YES];
    
}
- (void)changeNavigatinonRightItem
{
    if (_isEditting)
    {
        [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
    else
    {
        [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditStatus)];
    }
}

- (BOOL)nameIsExist:(NSString*)name
{
    BOOL isexist = NO;
    for (NSString *oldStr in _dataArr) {
        if ([oldStr isEqualToString:name])
        {
            isexist = YES;
        }
    }
    return isexist;
}

@end
