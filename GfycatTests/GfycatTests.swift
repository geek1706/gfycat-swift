//
//  GfycatTests.swift
//  GfycatTests
//
//  Created by trungnd on 9/28/16.
//  Copyright © 2016 redvn. All rights reserved.
//

import XCTest
@testable import Gfycat

class GfycatTests: XCTestCase {
    
    var testExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTrending() {
        
        testExpectation = self.expectation(description: #function)
        
        Gfycat.trending { (results, error) in
            
            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(results, "results is nil")
            
            self.testExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            print(error)
        }
    }
    
    func testTrendingWithTagName() {
        
        testExpectation = self.expectation(description: #function)
        
        Gfycat.trending("funny") { (results, error) in
            
            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(results, "results is nil")
            
            self.testExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            print(error)
        }
    }
    
    func testTrendingTags() {
        
        testExpectation = self.expectation(description: #function)
        
        Gfycat.trendingTags { (results, error) in
        
            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(results, "results is nil")
            
            self.testExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            print(error)
        }
    }
    
    func testTrendingTagsPopulated() {
        
        testExpectation = self.expectation(description: #function)
        
        Gfycat.trendingTagsPopulated { (results, error) in
            
            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(results, "results is nil")
            
            self.testExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            print(error)
        }
    }
    
    func testSearch() {
        
        testExpectation = self.expectation(description: #function)
        
        Gfycat.search("funny") { (results, error) in
            
            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(results, "results is nil")
            
            self.testExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) in
            print(error)
        }
    }
}
