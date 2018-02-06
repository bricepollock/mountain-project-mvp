//
//  MountainServiceTests.swift
//  MountainProjectDemoAppTests
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//


import XCTest
@testable import MountainProjectDemoApp

class MountainServiceTests: XCTestCase {
    let service = MountainService()
    
    func testRouteQuery_empty() {
        let routeList = [Int]()
        let result = service.routeQuery(from: routeList)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testRouteQuery_one() {
        let firstRoute = 1234
        let routeList = [firstRoute]
        let result = service.routeQuery(from: routeList)
        let expected = "\(firstRoute)"
        XCTAssertEqual(result, expected)
    }
    
    func testRouteQuery_two() {
        let firstRoute = 1234
        let secondRoute = 144444444444
        let routeList = [firstRoute, secondRoute]
        let result = service.routeQuery(from: routeList)
        let expected = "\(firstRoute),\(secondRoute)"
        XCTAssertEqual(result, expected)
    }
    
    func testRouteQuery_over() {
        let repeatRoute = 1
        let routeList = Array(repeating: repeatRoute, count: 140)
        let result = service.routeQuery(from: routeList)
        
        let expected = String(repeating: "\(repeatRoute),", count: 100).dropLast()
        XCTAssertEqual(result, String(expected))
    }
}
