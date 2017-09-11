//
//  EditableCell.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditableCell;
@protocol EditableCellDelegate <NSObject>

- (void)textEditDone:(EditableCell*)cell text:(NSString*)text;

@end

@interface EditableCell : UITableViewCell
@property(nonatomic,weak)id<EditableCellDelegate>delegate;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,assign)BOOL editable;
@end
