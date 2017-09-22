//
//  ProjectDetailCell.h
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectDetailCell;
@protocol ProjectDetailCellDelegate <NSObject>

- (void)keyEditDone:(ProjectDetailCell*)cell text:(NSString*)text;
- (void)valueEditDone:(ProjectDetailCell*)cell text:(NSString*)text;

@end

@interface ProjectDetailCell : UITableViewCell
@property(nonatomic,weak)id<ProjectDetailCellDelegate>delegate;
@property(nonatomic,assign)BOOL editable;
- (void)setKey:(NSString*)k value:(NSString*)v;
@end
