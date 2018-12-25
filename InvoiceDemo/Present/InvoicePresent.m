//
//  Present.m
//  MVP-UITableView-Demo1
//
//  Created by 邱中卫 on 2018/11/23.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "InvoicePresent.h"
#import "InvoicePresentDelegate.h"
#import "InvoiceSectionModel.h"
#import "InvoiceRowModel.h"

@interface InvoicePresent () <InvoicePresentDelegate>

@end

@implementation InvoicePresent

- (instancetype)init {
    if (self = [super init]) {
        [self dataArray];
    }
    return self;
}

#pragma mark 代理
//section左边的按钮
- (void)sectionSelectAll:(BOOL)isSelect section:(NSInteger)section {
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        if (i == section) {//点击的那个section
            @synchronized (self) {
                InvoiceSectionModel *model = self.dataArray [i];
                model.isSelect = isSelect;
                for (int j = 0; j < model.cellArray.count; j ++) {
                    InvoiceRowModel *row = model.cellArray [j];
                    row.isSelect = isSelect;
                }
            }
       
            if (self.delegate && [self.delegate respondsToSelector:@selector(reloadSection:)]) {
                [self.delegate reloadSection:section];
            }
        }
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelect == NO"];
    NSArray *filterArray = [self.dataArray filteredArrayUsingPredicate:predicate];
    NSLog(@"filterArray:%@", filterArray);
    //过滤整个数据的section是否全选中
    if (filterArray.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
            [self.delegate reloadAllSelect:NO];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
            [self.delegate reloadAllSelect:YES];
        }
    }
    
}
//section右边的上下箭头
- (void)sectionDidClick:(BOOL )isSelect indexPath:(NSIndexPath *)indexPath {
     @synchronized (self) {
         InvoiceSectionModel *model = self.dataArray [indexPath.section];
         InvoiceRowModel *rowModel = model.cellArray [indexPath.row];
         rowModel.isSelect = isSelect;
         
         [self.dataArray removeObject:model];
     }

    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
        [self.delegate reloadUI];
    }

}
//row左边的按钮
- (void)rowDidClick:(BOOL)isSelect indexPath:(NSIndexPath *)indexPath {
    
    InvoiceSectionModel *model = self.dataArray [indexPath.section];
    model.isSelect = isSelect;
    for (int j = 0; j < model.cellArray.count; j ++) {
        InvoiceRowModel *row = model.cellArray [j];
        if (j == indexPath.row) {
            row.isSelect = isSelect;
        }
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelect == NO"];
    NSArray *filterArray = [model.cellArray filteredArrayUsingPredicate:predicate];
    NSLog(@"filterArray:%@", filterArray);
    
   // filterArray.count > 0有未选中的
    if (filterArray.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
            [self.delegate reloadSectionHeadView:indexPath.section withSelect:NO];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
            [self.delegate reloadSectionHeadView:indexPath.section withSelect:YES];
        }
    }
    
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelect == NO"];
        NSArray *filterArray = [self.dataArray filteredArrayUsingPredicate:predicate];
        NSLog(@"filterArray:%@", filterArray);
        //过滤整个数据的section是否全选中
        if (filterArray.count > 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
                [self.delegate reloadAllSelect:NO];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
                [self.delegate reloadAllSelect:YES];
            }
        }
    }
}

#pragma mark - 全选事件
//全选
- (void)invoiceReloadData:(BOOL)isSelect {
    @synchronized (self) {
        for (int i = 0; i < self.dataArray.count; i ++) {
            InvoiceSectionModel *model = self.dataArray [i];
            model.isSelect = isSelect;
            for (int j = 0; j < model.cellArray.count; j ++) {
                InvoiceRowModel *row = model.cellArray [j];
                row.isSelect = isSelect;
            }
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadUI)]) {
        [self.delegate reloadUI];
    }
}
#pragma mark load lazy

//懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        for (int i=0; i<10; i++) {
            InvoiceSectionModel *model = [[InvoiceSectionModel alloc]init];
            model.title = [NSString stringWithFormat:@"%d",i];
            model.isExpand = NO;
            model.isSelect = NO;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (int j=0; j<5; j++) {
                InvoiceRowModel *cell = [[InvoiceRowModel alloc]init];
                cell.title = [NSString stringWithFormat:@"LivenCell==Section:%d,Row:%d",i,j];
                [array addObject:cell];
            }
            model.cellArray = array;
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
    
}
@end
