//
//  KKUtilsCategoriesTests.m
//  KKUtilsTests
//
//  Created by Mehmet Karagöz on 24.01.2020.
//  Copyright © 2020 Tolga Seremet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KKUtils/KKUtils.h>
#import <KKUtils/NSURL+KKUtils.h>

@interface KKUtilsCategoriesTests : XCTestCase

@end

@implementation KKUtilsCategoriesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - NSURL

- (void)testQueryItems {
    NSURL *givenURL = [NSURL URLWithString:@"https://qumpara.com/mehmet?email=mehmet@kokteyl.com&company=kokteyl"];
    NSDictionary *queryItems = [givenURL queryItems];
    
    NSDictionary *expectedQueryItems = @{
        @"email":@"mehmet@kokteyl.com",
        @"company":@"kokteyl",
    };
    
    XCTAssertEqualObjects(expectedQueryItems, queryItems, @"The desired query items did not match the expected items");
}

- (void)testQueryItemsEmpty {
    NSURL *givenURL = [NSURL URLWithString:@"https://qumpara.com/mehmet"];
    NSDictionary *queryItems = [givenURL queryItems];
    
    NSDictionary *expectedQueryItems = @{};
    
    XCTAssertEqualObjects(expectedQueryItems, queryItems, @"The desired query items did not match the expected items");
}

- (void)testQueryItemsInvalid {
    NSURL *givenURL = [NSURL URLWithString:@"ht://dsfsfsf"];
    NSDictionary *queryItems = [givenURL queryItems];
    
    NSDictionary *expectedQueryItems = @{};
    
    XCTAssertEqualObjects(expectedQueryItems, queryItems, @"The desired query items did not match the expected items");
}

@end
