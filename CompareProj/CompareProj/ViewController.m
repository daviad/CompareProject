//
//  ViewController.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ViewController.h"
#import "EditProjControllerViewController.h"
#import "ExcelView.h"

#import <Realm/Realm.h>
#import "Project.h"
#import "RLMRealm+AGDynamic.h"


@interface ViewController ()
@property(nonatomic,retain) NSMutableArray *leftTableDataArray;//表格第一列数据
@property(nonatomic,retain) NSMutableArray *excelDataArray;//表格数据
@property(nonatomic,retain) NSMutableArray *rightTableHeadArray;//表格第一行表头数据
@property(nonatomic,retain) NSMutableArray *allTableDataArray;//表格所有数据
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    EditProjControllerViewController *childCtr = [[EditProjControllerViewController alloc] init];
//    [self addChildViewController:childCtr];
//    [self.view addSubview:childCtr.view];
    [self.navigationController pushViewController:childCtr animated:NO];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建项目" style:UIBarButtonItemStylePlain target:self action:@selector(createProj)];
//    
//    
//    self.leftTableDataArray=(NSMutableArray *)@[@"塔城",@"哈密",@"和田",@"阿勒泰",@"克州"];
//    self.rightTableHeadArray=(NSMutableArray *)@[@"当日收入（万）",@"同比",@"环比",@"当月收入（万）",@"同比",@"环比",@"当年收入（万）",@"同比",@"环比"];
//    self.excelDataArray=(NSMutableArray *)@[@[@"2.91111111111111111",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%11111111111111111111",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"]];
//    
//    
//    self.allTableDataArray=(NSMutableArray *)@[@[@"地区",@"当日收入（万）",@"同比",@"环比",@"当月收入（万）",@"同比",@"环比",@"当年收入（万）",@"同比",@"环比"],@[@"塔城",@"2.91111111111111111111111111111111111111111111111111111111",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"哈密",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"和田",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"阿勒泰",@"2.9",@"2%",@"3%",@"3.0",@"4%11111111111111111111",@"5%",@"18",@"4.5%",@"6.8%"],@[@"克州",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"]];
    
    //    self.allTableDataArray=[NSMutableArray arrayWithCapacity:10];
    //    NSMutableArray *fristDatas=[NSMutableArray arrayWithCapacity:10];
    //    [fristDatas addObject:@"标题abc"];
    //    for (int i=0; i<3; i++) {
    //        [fristDatas addObject:[NSString stringWithFormat:@"标题%d",i]];
    //    }
    //    [self.allTableDataArray addObject:fristDatas];
    //    for (int i=0; i<22; i++) {
    //        NSMutableArray *rowDatas=[NSMutableArray arrayWithCapacity:10];
    //        [rowDatas addObject:[NSString stringWithFormat:@"标题%d",i]];
    //        for (int j=0; j<3;j++) {
    //            [rowDatas addObject:[NSString stringWithFormat:@"数据%d",j]];
    //        }
    //        [self.allTableDataArray addObject:rowDatas];
    //    }
    //
    //    NSLog(@"%@",self.allTableDataArray);
    
    //代码方式添加
//    ExcelView *excelView=[[ExcelView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    excelView.topTableHeadDatas=self.rightTableHeadArray;
//    excelView.leftTabHeadDatas=self.leftTableDataArray;
//    excelView.tableDatas=self.excelDataArray;
//    excelView.isLockFristColumn=YES;
//    excelView.isLockFristRow=YES;
//    excelView.isColumnTitlte=YES;
//    excelView.columnTitlte=@"地区";
//    [excelView show];
//    [self.view addSubview:excelView];
//    
    
    ////    xib布局添加方式
    //    self.mExcelView.allTableDatas=self.allTableDataArray;
    //    self.mExcelView.isLockFristColumn=YES;
    //    self.mExcelView.isLockFristRow=YES;
    //    self.mExcelView.isColumnTitlte=YES;
    //    self.mExcelView.columnTitlte=@"地区";
    //    self.mExcelView.columnMaxWidth=200;
    //    self.mExcelView.columnMinWidth=100;
    //    [self.mExcelView showWithLeftBlock:^(CGPoint contentOffset) {
    //        NSLog(@"滚动到了最左侧！");
    //        NSLog(@"偏移量：%f",contentOffset.x);
    //    } AndWithRigthBlock:^(CGPoint contentOffset) {
    //        NSLog(@"滚动到了最右侧！");
    //        NSLog(@"偏移量：%f",contentOffset.x);
    //    }];
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//
//    RLMResults *proResults = [Project allObjects];
//    if (proResults.count > 0) {
//        Project *p = proResults[0];
//        NSLog(@"p.name = %@",p.name);
//        
//        Project *pt = [[Project alloc] initWithValue:@[@"1",@"pro1",@"p1",@"p2"]];
//        [[RLMRealm defaultRealm] transactionWithBlock:^{
//            [[RLMRealm defaultRealm] addObject:pt];
//        }];
//    }
//    else
//    {
//        Project *pro = [[Project alloc] init];
//        pro.id = @"1";
//        pro.name = @"pro1";
//        [realm transactionWithBlock:^{
//            [realm addObject:pro];
//        }];
//    }


}


// also see realm dynamic tests
// https://github.com/realm/realm-cocoa/blob/123f97cdb2819397e289e088558f36e365e712a7/Realm/Tests/DynamicTests.m
- (void)testDynamic {
//    [RLMRealm setSchemaVersion:1 forRealmAtPath:RLMTestRealmPath() withMigrationBlock:^(RLMMigration *migration, NSUInteger oldSchemaVersion) {
//    }];
//
//    RLMProperty *propA = [[RLMProperty alloc] initWithName:@"uuid" type:RLMPropertyTypeString objectClassName:nil indexed:YES];
//    RLMProperty *propB = [[RLMProperty alloc] initWithName:@"title" type:RLMPropertyTypeString objectClassName:nil indexed:NO];
//    RLMObjectSchema *objectSchema = [[RLMObjectSchema alloc] initWithClassName:@"TrulyDynamicObject" objectClass:RLMObject.class properties:@[propA, propB]];
//    RLMSchema *schema = [[RLMSchema alloc] init]; // it would be great to have RLMSchema method like +schemaWithClassName:objectClass:properties
//    schema.objectSchema = @[objectSchema];
//
//    RLMRealm *dyrealm = [RLMRealm realmWithPath:RLMTestRealmPath() key:nil readOnly:NO inMemory:NO dynamic:YES schema:schema error:nil];
//
//    [dyrealm beginWriteTransaction];
//    [dyrealm createObject:@"TrulyDynamicObject" withValue:@{@"uuid": [[NSUUID UUID] UUIDString], @"title": @"item title"}];
//    [dyrealm commitWriteTransaction];
//
//    RLMResults *results = [dyrealm allObjects:@"TrulyDynamicObject"];
//    for (id obj in results) {
//        NSLog(@"%@ %@", obj[@"uuid"], obj[@"title"]);
//    }
}

//- (void)createProj
//{
//    [self.navigationController pushViewController:[EditProjControllerViewController new] animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
