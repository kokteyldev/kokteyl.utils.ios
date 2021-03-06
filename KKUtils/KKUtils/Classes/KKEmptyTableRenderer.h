//
//  KKEmptyTableRenderer.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.11.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KKEmptyTableRendererDelegate <NSObject>
@optional
- (void)emptyTableRendererDidRequestNewItem;
@end

@protocol KKIIdentifiable;
@protocol KKEmptyTableRendererCellDelegate <NSObject, KKIIdentifiable>
@optional
- (void)setDelegate:(id<KKEmptyTableRendererDelegate>)delegate;
- (void)setData:(id)data;
+ (CGFloat)heightForData:(id)data;
+ (CGFloat)height;
@end

@interface KKEmptyTableRenderer : NSObject <UITableViewDelegate, UITableViewDataSource>
+ (instancetype)emptyTableRendererWithEmptyCellClass:(Class)emptyCellClass
                                       emptyCellData:(id)emptyCellData
                                           tableView:(UITableView *)tableView
                                            delegate:(id<KKEmptyTableRendererDelegate>)delegate;
- (void)render;
@end


