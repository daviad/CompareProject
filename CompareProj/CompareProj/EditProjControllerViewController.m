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

@interface EditProjControllerViewController ()<EditControllerDelegate>
{

}
@end

@implementation EditProjControllerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"projec list";
    EditController *childCtr = [[EditController alloc] initWithDataArr:[@[@"jiu dian yuding",@"yi fu xuanze"] mutableCopy]];
    [self addChildViewController:childCtr];
    [self.view addSubview:childCtr.view];
    childCtr.delegate = self;
}

#pragma mark- EditControllerDelegate
- (void)jumpToDetailController
{
    [self.navigationController pushViewController:[PropertyController new] animated:YES];
}
@end
