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
    [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView)];
    _isEditting = NO;
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[EditableCell class] forCellReuseIdentifier:ReuseCell];
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 44)];
    [addBtn setTitle:@"add ...." forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    //    [addBtn setTintColor:[UIColor redColor]];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _tableView.tableFooterView = addBtn;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



//// _______________________________________________________________________________________________________________
//// this protocol can provide information about cells before they are displayed on screen.
//
//@protocol UITableViewDataSourcePrefetching <NSObject>
//
//@required
//
//// indexPaths are ordered ascending by geometric distance from the table view
//- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
//
//@optional
//
//// indexPaths that previously were considered as candidates for pre-fetching, but were not actually used; may be a subset of the previous call to -tableView:prefetchRowsAtIndexPaths:
//- (void)tableView:(UITableView *)tableView cancelPrefetchingForRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

#pragma mark--  UITableViewDelegate<NSObject, UIScrollViewDelegate>
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 44;
//}

//
//// Accessories (disclosures).
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

// Selection

//// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate jumpToDetailControllerWithIndex:indexPath.row];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"delete1";
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak EditController *weakSelf = self;
    NSMutableArray *resultArr = [NSMutableArray array];
    if ([self.delegate needEidtDetail]) {
        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"eidt" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"");
            [weakSelf.delegate clickEditDetail];
            tableView.editing = NO;
        }];
        [resultArr addObject:action0];
    }

    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakSelf.delegate deleteRowsAtIndexPath:indexPath];
        [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        tableView.editing = NO;
    }];
    [resultArr addObject:action1];
    
    return resultArr;
    
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//
//// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED;

// Moving/reordering

//// Allows customization of the target row for a particular row as it is being moved/reordered
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//
//// Indentation
//
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//
//// Copy/Paste.  All three methods must be implemented by the delegate.
//
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
//
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);



#pragma mark-- evnet
- (void)addItem
{
    [_dataArr addObject:@""];
    //    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_projs.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self editTableView];
    
}

- (void)editTableView
{
    _isEditting = !_isEditting;
    
    if (_isEditting)
    {
        [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView)];
    }
    else
    {
        [GlobalUIControl sharedInstance].navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView)];
    }
    [_tableView setEditing:_isEditting animated:YES];
    [_tableView reloadData];
}


#pragma mark-  EditableCellDelegate <NSObject>
- (void)textEditDone:(EditableCell*)cell text:(NSString*)text
{
    if (text.length > 0) {
        NSIndexPath *index = [_tableView indexPathForCell:cell];
        BOOL isexist = NO;
        for (NSString *oldStr in _dataArr) {
            if ([oldStr isEqualToString:text])
            {
                isexist = YES;
            }
        }
        
        if (!isexist)
        {
            [_dataArr replaceObjectAtIndex:index.row withObject:text];
            [self.delegate addItem:text atIndex:index.row];
        }
        else
        {
            NSLog(@"please new item");
        }
    }
}

@end
