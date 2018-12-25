//
//  rowModel.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceRowModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL     isSelect;
@end

NS_ASSUME_NONNULL_END
