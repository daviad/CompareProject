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
    _keyTextView.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    _valueTextView.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
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
    }
    else
    {
        _keyTextView.layer.borderWidth = 0;
//        _keyTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        _valueTextView.layer.borderWidth = 0;
//        _valueTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    
}

- (void)setKey:(NSString *)k value:(NSString *)v
{
    _keyTextView.text = k;
    _valueTextView.text = v;
}
#pragma mark-- UITextViewDelegate
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

@end
