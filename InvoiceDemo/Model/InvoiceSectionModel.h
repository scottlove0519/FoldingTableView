//
//  sectionModel.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceSectionModel : NSObject
@property (nonatomic,assign) BOOL     isExpand;
@property (nonatomic,assign) BOOL     isSelect;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSArray  *cellArray;

@end

NS_ASSUME_NONNULL_END
