//
//  KKEmptyTableRenderer.m
//  KKUtils
//
//  Created by Tolga Seremet on 24.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "KKEmptyTableRenderer.h"
#import "KKProtocols.h"
#import "UITableView+KKUtils.h"

@implementation KKEmptyTableRenderer {
    Class _emptyCellClass;
    id _emptyCellData;
    __weak UITableView *_tableView;
    __weak id<KKEmptyTableRendererDelegate> _delegate;
}

#pragma mark - NSObject

+ (instancetype)emptyTableRendererWithEmptyCellClass:(Class)emptyCellClass
                                       emptyCellData:(id)emptyCellData
                                           tableView:(UITableView *)tableView
                                            delegate:(id<KKEmptyTableRendererDelegate>)delegate {
    return [[[self class] alloc] initWithEmptyCellClass:emptyCellClass
                                          emptyCellData:emptyCellData
                                              tableView:tableView
                                               delegate:delegate];
}

- (instancetype)initWithEmptyCellClass:(Class)emptyCellClass
                         emptyCellData:(id)emptyCellData
                             tableView:(UITableView *)tableView
                              delegate:(id<KKEmptyTableRendererDelegate>)delegate {
    if (!(self = [super init])) return nil;
    _emptyCellClass = emptyCellClass;
    _emptyCellData = emptyCellData;
    _tableView = tableView;
    _delegate = delegate;
    return self;
}

#pragma mark - Public

- (void)render {
    [_tableView registerNibs:@[[_emptyCellClass identifier]]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView reloadData];
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_emptyCellClass respondsToSelector:@selector(heightForData:)]) {
        return [((id<KKEmptyTableRendererCellDelegate>) _emptyCellClass) heightForData:_emptyCellData];
    } else  if ([_emptyCellClass respondsToSelector:@selector(height)]) {
        return [((id<KKEmptyTableRendererCellDelegate>) _emptyCellClass) height];
    } else {
        return 50.0f;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [((id<KKEmptyTableRendererCellDelegate>) cell) setDelegate:_delegate];
    }
    if ([cell respondsToSelector:@selector(setData:)] && _emptyCellData) {
        [((id<KKEmptyTableRendererCellDelegate>) cell) setData:_emptyCellData];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView dequeueReusableCellWithIdentifier:[_emptyCellClass identifier] forIndexPath:indexPath];
}

@end
