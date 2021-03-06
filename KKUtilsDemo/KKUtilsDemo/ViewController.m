//
//  ViewController.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 14.11.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#import "ViewController.h"

#import <KKUtils/KKUtils.h>
#import "TableViewCell.h"

NSString* const kKKCellIdentifier = @"TableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> @end

@implementation ViewController {
    KKAnimatedImageView *animated;
    IBOutlet UITableView *_tableView;
    NSArray<CustomObject *> *items;

    KKRefreshControl *_refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    animated = [KKAnimatedImageView animatedImageViewWithFrame:CGRectMake(100, 100, 50, 50)
    //                                                     imageName:@"Page "
    //                                                numberOfFrames:62
    //                                             animationDuration:1.2];
    //    [self.view addSubview:animated];
    [_tableView registerNibs:@[kKKCellIdentifier]];
    //    self.navigationController.navigationBar.prefersLargeTitles = YES;
    //    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    //    self.extendedLayoutIncludesOpaqueBars = YES;

    _refreshControl = [KKRefreshControl refreshControlWithImageBaseName:@"Page %@" startImageIndex:1 endImageIndex:30 spinnerWidth:34 animationDuration:.7];

    [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    //    _tableView.refreshControl = _refreshControl;

    //    _tableView.tableHeaderView = _refreshControl;

    _refreshControl.layer.zPosition = -1;
    //    [_refreshControl beginRefreshing];

    //
    ////        _refreshControl = [[QPRefreshControl alloc] init];
    ////        _refreshControl.tintColor = [UIColor lightGrayColor];
    ////        [_refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    ////        [tableView addSubview:_refreshControl];
    ////        _refreshControl.layer.zPosition = -1;
    ////        [_refreshControl beginRefreshing];
    ////
    //
    //
    [self loadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kKKCellIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((TableViewCell *)cell).data = items[indexPath.row];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)loadData {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self->items = [self items];
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;

        [self->_tableView reloadData];
        [self->_refreshControl endRefreshing];
    });
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self disablePanningOfCells];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self disablePanningOfCells];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self enablePanningOfCells];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self enablePanningOfCells];
}

- (void)enablePanningOfCells {
    [self changePanningStatusOfCells:YES];
}

- (void)disablePanningOfCells {
    [self changePanningStatusOfCells:NO];
}

- (void)changePanningStatusOfCells:(BOOL)isPanningEnabled {
    for (KKSlideableTVC *slideableCell in _tableView.visibleCells) {
        slideableCell.isPanEnabled = isPanningEnabled;
    }
}

- (NSArray<CustomObject *> *)items {
    return @[
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"],
        [CustomObject customObjectWithName:@"Ayse"],
        [CustomObject customObjectWithName:@"Fatma"],
        [CustomObject customObjectWithName:@"Ali"],
        [CustomObject customObjectWithName:@"Mustafa"],
        [CustomObject customObjectWithName:@"Murat"]
    ];
}

@end

@implementation CustomObject

+ (instancetype)customObjectWithName:(NSString *)name {
    return [[[self class] alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
