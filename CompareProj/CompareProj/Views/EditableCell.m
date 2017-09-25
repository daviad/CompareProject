//
//  EditableCell.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()<UITextViewDelegate>
{
    UITextView *_textView;
//    SSCheckBoxView *_checkBox;
}
@end

@implementation EditableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textView];
        _textView.userInteractionEnabled = NO;
        _textView.delegate = self;
//        _checkBox = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(0, 0, 30, 30) style:kSSCheckBoxViewStyleMono checked:NO];
//        [_checkBox setStateChangedTarget:self selector:@selector(checkStatusChange)];
//        [self.contentView addSubview:_checkBox];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_editable) {
        
    }
    
    _textView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
        }
    }
}

- (void)setText:(NSString *)text
{
    if ([text isEqualToString:@""]) {
        _textView.text = @"write";
        [_textView becomeFirstResponder];
        _textView.userInteractionEnabled = YES;
    }
    _textView.text = text;
}

- (void)setEditable:(BOOL)editable
{
    _textView.userInteractionEnabled = editable;
}

#pragma mark-- UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.delegate textEditDone:self text:textView.text];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.delegate textDidChange:self tex:textView.text];
}
#pragma mark- event
- (void)checkStatusChange
{
    
}
@end
