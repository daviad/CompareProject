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
}
@end

@implementation EditableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_textView];
        _textView.userInteractionEnabled = NO;
        _textView.delegate = self;
//        _textView.laout
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
@end
