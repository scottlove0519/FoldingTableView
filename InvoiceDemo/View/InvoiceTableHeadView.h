//
//  InvoiceTableHeadView.h
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InvoiceAllSelectDelegate <NSObject>

@optional;

- (void)allSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_BEGIN


@interface InvoiceTableHeadView : UIView

@property (nonatomic, weak) id <InvoiceAllSelectDelegate> delegate;

- (void)setMonthTitle:(NSString*)title;
- (void)setSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
