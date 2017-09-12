//
//  EditController.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditControllerDelegate <NSObject>

- (void)jumpToDetailController;

@end

@interface EditController : UIViewController
- (instancetype)initWithDataArr:(NSMutableArray*)arr;
@property(nonatomic,weak)id<EditControllerDelegate>delegate;
@end
