//
//  EditController.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/12.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditController;
@protocol EditControllerDelegate <NSObject>
- (void)jumpToDetailControllerWithIndex:(NSInteger)index;
- (void)clickEditDetailAtIndexPath:(NSIndexPath*)indexPath;
- (void)deleteRowsAtIndexPath:(NSIndexPath*)indexPath;
- (void)editItem:(NSString*)text atIndex:(NSInteger)index;
- (BOOL)needEidtDetail;
- (void)editController:(EditController *)ctr moveRowAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex;
- (void)compare;
@end

@interface EditController : UIViewController
- (instancetype)initWithDataArr:(NSMutableArray*)arr;
@property(nonatomic,weak)id<EditControllerDelegate>delegate;
@end
