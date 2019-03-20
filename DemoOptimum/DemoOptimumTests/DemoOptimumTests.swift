//
//  DemoOptimumTests.swift
//  DemoOptimumTests
//
//  Created by Dharani on 20/3/19.
//  Copyright © 2019 Dharani. All rights reserved.
//

import XCTest
@testable import DemoOptimum

class DemoOptimumTests: XCTestCase {


    func testJson() {
        
        let result = "result".jsonData()
        var path = Bundle.main.path(forResource: "contents", ofType: "json")
        // print(" Actual path  \(path)")
        //  XCTAssertNil(path)
        XCTAssertEqual(result, path)
    }
    

}
