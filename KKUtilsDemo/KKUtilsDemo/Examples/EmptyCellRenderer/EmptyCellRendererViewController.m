//
//  EmptyCellRendererViewController.m
//  KKUtilsDemo
//
//  Created by Tolga Seremet on 25.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import "EmptyCellRendererViewController.h"
#import "EmptyTableViewCell.h"
#import <KKUtils/KKUtils.h>

@interface EmptyCellRendererViewController () <UITableViewDelegate, UITableViewDataSource, KKEmptyTableRendererDelegate> @end

@implementation EmptyCellRendererViewController {

    IBOutlet UITableView *TBMain;
    KKEmptyTableRenderer *_emptyTableRenderer;
}

#pragma mark - IBActions

- (IBAction)switchToEmptyData:(id)sender {
    _emptyTableRenderer = [KKEmptyTableRenderer emptyTableRendererWithEmptyCellClass:[EmptyTableViewCell class]
                                                                       emptyCellData:@{@"emptyText": @"here is your empty state text"}
                                                                           tableView:TBMain
                                                                            delegate:self];
    [_emptyTableRenderer render];
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [[self data] objectAtIndex:indexPath.row];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self data].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView dequeueReusableCellWithIdentifier:@"rendererCell" forIndexPath:indexPath];
}

#pragma mark - <KKEmptyTableRendererDelegate>

- (void)emptyTableRendererDidRequestNewItem {
    NSLog(@"Empty cell renderer asks for new item");
}

#pragma mark - Data

- (NSArray *)data {
    static NSArray *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = @[@"Ayse", @"Fatma", @"Zeynep", @"Ahmet", @"Mehmet", @"Ali"];
    });
    return data;
}

@end
