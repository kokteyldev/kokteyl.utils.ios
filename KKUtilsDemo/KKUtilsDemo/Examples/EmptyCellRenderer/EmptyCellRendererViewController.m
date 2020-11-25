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
    NSArray<NSString *> *_data;
    KKEmptyTableRenderer *_emptyTableRenderer;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @[@"Ayse", @"Fatma", @"Ahmet", @"Mehmet"];
}

#pragma mark - IBActions

- (IBAction)switchToEmptyData:(id)sender {
    _emptyTableRenderer = [KKEmptyTableRenderer emptyTableRendererWithEmptyCellClass:[EmptyTableViewCell class]
                                                                       emptyCellData:@"here is your empty state text"
                                                                           tableView:TBMain
                                                                            delegate:self];
    [_emptyTableRenderer render];
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView dequeueReusableCellWithIdentifier:@"rendererCell" forIndexPath:indexPath];
}

#pragma mark - <KKEmptyTableRendererDelegate>

- (void)emptyTableRendererDidRequestNewItem {
    NSLog(@"Empty cell renderer asks for new item");
}

@end
