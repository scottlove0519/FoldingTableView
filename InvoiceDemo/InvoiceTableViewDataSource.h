//
//  InvoiceTableViewDataSource.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id items , NSIndexPath *indexPath);
typedef void (^TableViewHeadConfigureBlock)(id head, id items , NSInteger section);


@interface InvoiceTableViewDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
     headIdentifier:(NSString *)aHeadIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
 configureHeadBlock:(TableViewHeadConfigureBlock)aConfigureHeadBlock;

//@property (nonatomic, copy) TableViewCellConfigureBlock aConfigureCellBlock;
//@property (nonatomic, copy) TableViewHeadConfigureBlock aConfigureHeadBlock;

- (void)addAnItems:(NSArray * _Nonnull)anItems;

@end

