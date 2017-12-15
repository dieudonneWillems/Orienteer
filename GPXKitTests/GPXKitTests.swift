//
//  GPXKitTests.swift
//  GPXKitTests
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import XCTest
@testable import GPXKit

class GPXKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGPXParser() {
        let myBundle = Bundle(for: GPXKitTests.self)
        let testURL = myBundle.url(forResource: "Orienteringsloop_Amerongse_Berg_9km", withExtension: "gpx")
        if testURL != nil {
            let parser = GPXParser(contentsOf: testURL!)
            if parser != nil {
                parser!.parse()
            } else {
                XCTFail("Could not create parser for GPX file: \(String(describing: testURL))")
            }
        } else {
            XCTFail("Could not find URL for GPX resource in test: Orienteringsloop_Amerongse_Berg_9km.gpx")
        }
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
    
}
