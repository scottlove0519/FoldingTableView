//
//  rowCell.m
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "InvoiceRowCell.h"
#import "InvoiceRowModel.h"
#import <Masonry.h>
#import "UIButton+ImageTitleSpacing.h"
// 屏幕高度和宽度
#define SCREEN_WIDTH  [ UIScreen mainScreen ].bounds.size.width
#define SCREEN_HEIGHT [ UIScreen mainScreen ].bounds.size.height

@interface InvoiceRowCell ()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *detailLabel;
@end

@implementation InvoiceRowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo((SCREEN_WIDTH - 34)/3);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectButton.mas_right).offset(5);
        make.width.mas_equalTo((SCREEN_WIDTH - 34)/3);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        make.width.mas_equalTo((SCREEN_WIDTH - 34)/3);
        make.top.bottom.mas_equalTo(0);
    }];
}

- (void)setCellModel:(InvoiceRowModel*)model {
    self.selectButton.selected = model.isSelect;
    [self.selectButton setTitle:model.title forState:0];
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.title;
}
- (void)selectClick:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rowDidClick:indexPath:)]) {
        [self.delegate rowDidClick:sender.selected indexPath:self.indexPath];
    }
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton new];
        [_selectButton setImage:[UIImage imageNamed:@"Select_2"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"Select_1"] forState:UIControlStateSelected];
        [_selectButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_selectButton setTitleColor:[UIColor blueColor] forState:0];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_selectButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _selectButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:15.f];
        _detailLabel.textColor = [UIColor blackColor];
    }
    return _detailLabel;
}
@end
