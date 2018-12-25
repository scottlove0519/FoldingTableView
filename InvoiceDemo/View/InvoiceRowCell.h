//
//  rowCell.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoicePresentDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceRowCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id <InvoicePresentDelegate> delegate;
- (void)setCellModel:(id)model;
@end

NS_ASSUME_NONNULL_END
