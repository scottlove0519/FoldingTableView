//
//  Present.h
//  MVP-UITableView-Demo1
//
//  Created by 邱中卫 on 2018/11/23.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InvoicePresentDelegate.h"

NS_ASSUME_NONNULL_BEGIN


@interface InvoicePresent : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) id <InvoicePresentDelegate> delegate;
- (void)invoiceReloadData:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
