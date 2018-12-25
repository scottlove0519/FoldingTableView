//
//  sectionView.m
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "InvoiceSectionView.h"
#import "InvoiceSectionModel.h"
#import <Masonry.h>
#import "UIButton+ImageTitleSpacing.h"
// 屏幕高度和宽度
#define SCREEN_WIDTH  [ UIScreen mainScreen ].bounds.size.width
#define SCREEN_HEIGHT [ UIScreen mainScreen ].bounds.size.height

@interface InvoiceSectionView ()
@property (nonatomic, strong) UIButton            *arrowImageButton;
@property (nonatomic, strong) UILabel             *titleLabel;
@property (nonatomic, strong) UILabel             *detailLabel;
@property (nonatomic, strong) UIButton            *selectButton;
@property (nonatomic, strong) InvoiceSectionModel *model;
@end

@implementation InvoiceSectionView
/* 在构造方法中，创建UI*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor yellowColor];
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.arrowImageButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo((SCREEN_WIDTH - 34)/3);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.arrowImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(19, 10));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-5);
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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
    
    MASAttachKeys(self.contentView);
}
- (void)setCellModel:(InvoiceSectionModel*)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.title;
    [self.selectButton setTitle:model.title forState:0];
    self.selectButton.selected = model.isSelect;
    if (!model.isExpand) {       //关闭
//        self.selectButton.hidden = YES;
        self.arrowImageButton.imageView.transform = CGAffineTransformIdentity;
    }else{
        self.arrowImageButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        self.selectButton.hidden = NO;
    }
    
}
- (void)setSectionSelect:(BOOL)isSelect {
    self.selectButton.selected = isSelect;
}
- (void)btnClick:(UIButton *)sender{
    self.model.isExpand = ! self.model.isExpand;
    if (!self.model.isExpand) {
        self.arrowImageButton.imageView.transform = CGAffineTransformIdentity;
//        self.selectButton.hidden = YES;
    }else{
        self.arrowImageButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        self.selectButton.hidden = NO;
    }
    if (self.block) {
        self.block(self.model.isExpand);
    }
}
#pragma mark load lazy

- (void)selectClick:(UIButton*)sender {
    sender.selected = !sender.isSelected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionSelectAll: section:)]) {
        [self.delegate sectionSelectAll:sender.selected section:self.section];
    }
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton new];
        [_selectButton setImage:[UIImage imageNamed:@"Select_2"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"Select_1"] forState:UIControlStateSelected];
        [_selectButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_selectButton setTitleColor:[UIColor blueColor] forState:0];
        [_selectButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        _selectButton.hidden = YES;
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _selectButton;
}
- (UIButton *)arrowImageButton{
    if (!_arrowImageButton) {
        _arrowImageButton = [[UIButton alloc]init];
        [_arrowImageButton setImage:[UIImage imageNamed:@"Upay箭头-下(灰)"] forState:0];
        [_arrowImageButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowImageButton;
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
