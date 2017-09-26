//
//  EditableCell.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/11.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "EditableCell.h"
#import "IQTextView.h"
@interface EditableCell ()<UITextViewDelegate>
{
    IQTextView *_textView;
}
@end

@implementation EditableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textView = [[IQTextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textView];
        _textView.userInteractionEnabled = NO;
        _textView.delegate = self;
        _textView.placeholder = @"填写类别";
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
    _textView.frame = CGRectMake(10, 8, self.contentView.frame.size.width -10 , self.contentView.frame.size.height -16 );

//    if (_editable) {
//        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _textView.layer.borderWidth = 1;
//    } else {
//        _textView.layer.borderColor = [UIColor clearColor].CGColor;
//    }
    
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
    _editable = editable;
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
