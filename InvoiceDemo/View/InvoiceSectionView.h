//
//  sectionView.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoicePresentDelegate.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBackBlock)(BOOL);
typedef void(^AllSelectBlock)(BOOL);

@interface InvoiceSectionView : UITableViewHeaderFooterView
@property (nonatomic, assign) NSInteger       section;
@property (nonatomic,copy   ) CallBackBlock   block;
@property (nonatomic,copy   ) AllSelectBlock  allSelectBlock;
@property (nonatomic, weak) id <InvoicePresentDelegate> delegate;
- (void)setCellModel:(id)model;
- (void)setSectionSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
