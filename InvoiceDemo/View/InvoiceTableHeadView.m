//
//  InvoiceTableHeadView.m
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "InvoiceTableHeadView.h"
#import <Masonry.h>
#import "UIButton+ImageTitleSpacing.h"

@interface InvoiceTableHeadView ()
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UIButton *allSelButton;
@end

@implementation InvoiceTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self addSubview:self.monthLabel];
    [self addSubview:self.allSelButton];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(50);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.allSelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthLabel.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.top.bottom.mas_equalTo(0);
    }];
    MASAttachKeys(self);
}
- (void)setMonthTitle:(NSString*)title {
    self.monthLabel.text = title;
}
- (void)setSelect:(BOOL)isSelect {
    self.allSelButton.selected = isSelect;
}
- (void)buttonClick:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(allSelect:)]) {
        [self.delegate allSelect:sender.selected];
    }
}
#pragma mark load lazy

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [UILabel new];
        _monthLabel.textColor = [UIColor colorWithWhite:.5f alpha:1.f];
        _monthLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _monthLabel;
}
- (UIButton *)allSelButton {
    if (!_allSelButton) {
        _allSelButton = [UIButton new];
        [_allSelButton setTitle:@"全选" forState:0];
        [_allSelButton setTitleColor:[UIColor colorWithWhite:.5f alpha:1.f] forState:0];
        _allSelButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_allSelButton setImage:[UIImage imageNamed:@"Select_2"] forState:UIControlStateNormal];
        [_allSelButton setImage:[UIImage imageNamed:@"Select_1"] forState:UIControlStateSelected];
        [_allSelButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_allSelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelButton;
}
@end
