//
//  ViewController.m
//  InvoiceDemo
//
//  Created by 邱中卫 on 2018/12/24.
//  Copyright © 2018 qiuzhongwei. All rights reserved.
//

#import "ViewController.h"
#import "InvoiceTableViewDataSource.h"
#import "InvoiceRowCell.h"
#import "InvoiceSectionView.h"
#import "InvoiceSectionView.h"
#import "Present/InvoicePresent.h"
#import "InvoiceTableHeadView.h"

// 屏幕高度和宽度
#define SCREEN_WIDTH  [ UIScreen mainScreen ].bounds.size.width
#define SCREEN_HEIGHT [ UIScreen mainScreen ].bounds.size.height

@interface ViewController ()<InvoicePresentDelegate,InvoiceAllSelectDelegate>

@property (nonatomic, strong) InvoiceTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView                *tableView;
@property (nonatomic, strong) NSMutableArray             *sectionData;
@property (nonatomic, strong) InvoicePresent             *pt;
@property (nonatomic, strong) InvoiceTableHeadView       *tableHeadView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pt = [[InvoicePresent alloc]init];
    [self.view addSubview:self.tableHeadView];
    [self createTableView];
    [self.tableHeadView setMonthTitle:@"11月份"];
    [self.dataSource addAnItems:self.pt.dataArray];
    
}
- (void)createTableView {
    [self.view addSubview:self.tableView];
    
   
    __weak typeof (self) weakSelf = self;
    self.dataSource = [[InvoiceTableViewDataSource alloc]initWithItems:self.pt.dataArray
                                                        cellIdentifier:NSStringFromClass([InvoiceRowCell class])
                                                        headIdentifier:NSStringFromClass([InvoiceSectionView class])
                                                    configureCellBlock:^(InvoiceRowCell *cell, id items, NSIndexPath *indexPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [cell setCellModel:items];
        cell.indexPath = indexPath;
        cell.delegate = strongSelf.pt;
    } configureHeadBlock:^(InvoiceSectionView *head, id items, NSInteger section) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [head setCellModel:items];
        head.section = section;
        head.delegate = strongSelf.pt;
    }];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.pt.delegate = self;
}
#pragma mark - PresentDelegate
//刷新
- (void)reloadUI {
    [self.dataSource addAnItems:self.pt.dataArray];
    [self.tableView reloadData];
}
- (void)reloadSection:(NSInteger)section{
    [self.dataSource addAnItems:self.pt.dataArray];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)reloadSectionHeadView:(NSInteger)section withSelect:(BOOL)isSelect {
    [self.dataSource addAnItems:self.pt.dataArray];
    
    InvoiceSectionView *view = (InvoiceSectionView*)[self.tableView headerViewForSection:section];
    [view setSectionSelect:isSelect];
}
- (void)reloadAllSelect:(BOOL)isSelect {
    [self.tableHeadView setSelect:isSelect];
}
#pragma mark - InvoiceTableHeadViewDelegate
//最顶部的所有全选

- (void)allSelect:(BOOL)isSelect {
    [self.pt invoiceReloadData:isSelect];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 300) style:UITableViewStylePlain];
        _tableView.rowHeight = 200.0f;
        [_tableView registerClass:[InvoiceRowCell class] forCellReuseIdentifier:NSStringFromClass([InvoiceRowCell class])];
        [_tableView registerClass:[InvoiceSectionView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([InvoiceSectionView class])];
    }
    return _tableView;
}

- (InvoiceTableHeadView *)tableHeadView {
    
    if (!_tableHeadView) {
        _tableHeadView = [[InvoiceTableHeadView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 40)];
        _tableHeadView.delegate = self;
    }
    return _tableHeadView;
}

@end
