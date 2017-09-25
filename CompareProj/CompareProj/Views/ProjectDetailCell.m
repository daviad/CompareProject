//
//  ProjectDetailCell.m
//  CompareProj
//
//  Created by  dingxiuwei on 2017/9/14.
//  Copyright © 2017年  dingxiuwei. All rights reserved.
//

#import "ProjectDetailCell.h"

@interface ProjectDetailCell ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *keyTextView;
@property(nonatomic,strong)UITextView *valueTextView;
@property(nonatomic,strong)UIView *line;
@end

@implementation ProjectDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _keyTextView = [[UITextView alloc] init];
        [self.contentView addSubview:_keyTextView];
        _keyTextView.delegate = self;
        
        _valueTextView = [[UITextView alloc] init];
        [self.contentView addSubview:_valueTextView];
        _valueTextView.delegate = self;
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
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
    _keyTextView.frame = CGRectMake(0, 0, self.contentView.frame.size.width/2, self.contentView.frame.size.height);
    _valueTextView.frame = CGRectMake(self.contentView.frame.size.width/2, 0, self.contentView.frame.size.width/2, self.contentView.frame.size.height);
    _line.frame = CGRectMake(self.contentView.frame.size.width/2, 0, 1, self.contentView.frame.size.height);
}

- (void)setEditable:(BOOL)editable
{
    _keyTextView.userInteractionEnabled = editable;
    _valueTextView.userInteractionEnabled = editable;
    
    if (editable) {
        _keyTextView.layer.borderWidth = 1;
        _keyTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        _valueTextView.layer.borderWidth = 1;
        _valueTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        _line.backgroundColor = [UIColor clearColor];
    }
    else
    {
        _keyTextView.layer.borderWidth = 0;
//        _keyTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        _valueTextView.layer.borderWidth = 0;
//        _valueTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        _line.backgroundColor = [UIColor grayColor];
    }
    
}

- (void)setKey:(NSString *)k value:(NSString *)v
{
    _keyTextView.text = k;
    _valueTextView.text = v;
    if ([k isEqualToString:@""]) {
        [_keyTextView becomeFirstResponder];
    }
}
#pragma mark-- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_keyTextView == textView) {
        [self.delegate keyBeginEdit:self text:@""];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_valueTextView == textView) {
        [self.delegate valueEditDone:self text:textView.text];
    }
    else
    {
        [self.delegate keyEditDone:self text:textView.text];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_keyTextView == textView) {
        [self.delegate keyDidChange:self text:textView.text];
    }
}
@end
