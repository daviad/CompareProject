//
//  CompareController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "CompareController.h"
#import "ExcelView.h"
#import <Realm/Realm.h>

@interface CompareController ()
@property(nonatomic,retain) NSMutableArray *leftTableDataArray;//表格第一列数据
@property(nonatomic,retain) NSMutableArray *excelDataArray;//表格数据
@property(nonatomic,retain) NSMutableArray *rightTableHeadArray;//表格第一行表头数据
@property(nonatomic,retain) NSMutableArray *allTableDataArray;//表格所有数据
@end

@implementation CompareController

- (instancetype)initWithClassify:(ProjectClassify *)pc
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (Project *p in pc.rlmProjects) {
        [tempArr addObject:p];
    }
    self.leftTableDataArray = pc.properties;
    return [self initWithProjects:tempArr];
}

- (instancetype)initWithProjects:(NSArray<Project *> *)pjs
{
    if (self = [super init]) {
        NSMutableArray *headers = [[NSMutableArray alloc] init];
        NSMutableArray *excellArr = [NSMutableArray array];
        NSMutableArray *row1Arr = [NSMutableArray array];
        for (Project *p in pjs) {
            [headers addObject:p.name];
            Property *pro = [p.rlmProperties firstObject];
            [row1Arr addObject:pro.value];
        }
        [excellArr addObject:row1Arr];

        for (int i = 1; i < self.leftTableDataArray.count; i++) {
            NSMutableArray *rowArr = [NSMutableArray array];
            for (Project *p in pjs) {
                Property *pro = [p.rlmProperties objectAtIndex:i];
                [rowArr addObject:pro.value];
            }
            [excellArr addObject:rowArr];
        }
        
        self.rightTableHeadArray = headers;
        self.excelDataArray = excellArr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //代码方式添加
    ExcelView *excelView=[[ExcelView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    excelView.topTableHeadDatas=self.rightTableHeadArray;
    excelView.leftTabHeadDatas=self.leftTableDataArray;
    excelView.tableDatas=self.excelDataArray;
    excelView.isLockFristColumn=YES;
    excelView.isLockFristRow=YES;
    excelView.isColumnTitlte=YES;
    excelView.columnTitlte=@"地区";
    [excelView show];
    [self.view addSubview:excelView];
    
//    excelView.columnMaxWidth=200;
//    excelView.columnMinWidth=100;
    [excelView showWithLeftBlock:^(CGPoint contentOffset) {
        NSLog(@"滚动到了最左侧！");
        NSLog(@"偏移量：%f",contentOffset.x);
    } AndWithRigthBlock:^(CGPoint contentOffset) {
        NSLog(@"滚动到了最右侧！");
        NSLog(@"偏移量：%f",contentOffset.x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
