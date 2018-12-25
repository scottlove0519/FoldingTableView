//
//  InvoiceTableViewDataSource.m
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "InvoiceTableViewDataSource.h"
#import "InvoiceRowCell.h"
#import "InvoiceSectionView.h"
#import "InvoiceSectionModel.h"
#import "InvoiceRowModel.h"

@interface InvoiceTableViewDataSource ()
@property (nonatomic, strong) NSArray                     * items;/**< array */
@property (nonatomic, copy  ) NSString                    * cellIdentifiers;/**< cellIdentifier */
@property (nonatomic, copy  ) NSString                    * headIdentifiers;
@property (nonatomic, copy  ) TableViewCellConfigureBlock configureCellBlock;/**< block */
@property (nonatomic, copy  ) TableViewHeadConfigureBlock configureHeadBlock;/**< block */
@end
@implementation InvoiceTableViewDataSource
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
     headIdentifier:(NSString *)aHeadIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
 configureHeadBlock:(TableViewHeadConfigureBlock)aConfigureHeadBlock{
    
    if (self = [super init]) {
        self.items = anItems;
        self.cellIdentifiers = aCellIdentifier;
        self.headIdentifiers = aHeadIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
        self.configureHeadBlock = aConfigureHeadBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger) indexPath.section];
}

- (void)addAnItems:(NSArray * _Nonnull)anItems {
    self.items = anItems;
}
#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InvoiceRowCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers];
    InvoiceSectionModel *model = [self itemAtIndexPath:indexPath];
    id item = model.cellArray [indexPath.row];
    [cell setCellModel:item];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item ,indexPath);
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.items count];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    InvoiceSectionModel *model = self.items[section];
    return model.isExpand ? model.cellArray.count : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InvoiceRowCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    InvoiceSectionModel *model = [self itemAtIndexPath:indexPath];
    id item = model.cellArray [indexPath.row];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item ,indexPath);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    InvoiceSectionView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headIdentifiers];
    InvoiceSectionModel *model = self.items [section] ;
    [view setCellModel:model];
    //更变了section的cell数量，所以要刷新
    view.block = ^(BOOL isExpanded){
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    };
    if (self.configureHeadBlock) {
        self.configureHeadBlock(view, model, section);
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

///分隔线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
