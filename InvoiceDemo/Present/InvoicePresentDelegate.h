//
//  CellDelegate.h
//  MVP-UITableView-Demo1
//
//  Created by 邱中卫 on 2018/11/23.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>



//NS_ASSUME_NONNULL_BEGIN

@protocol InvoicePresentDelegate <NSObject>

@optional
//刷新最上面的全选
- (void)reloadAllSelect:(BOOL)isSelect;

//刷新整个section 包含cell
- (void)reloadSection:(NSInteger)section;

//刷新section的headView
- (void)reloadSectionHeadView:(NSInteger)section withSelect:(BOOL)isSelect;

//刷新整个表
- (void)reloadUI;

//每个section全选
- (void)sectionSelectAll:(BOOL)isSelect section:(NSInteger)section;

//折叠
- (void)sectionDidClick:(BOOL)isSelect indexPath:(NSIndexPath*)indexPath ;

// row单选点击
- (void)rowDidClick:(BOOL)isSelect indexPath:(NSIndexPath*)indexPath ;


@end

//NS_ASSUME_NONNULL_END
