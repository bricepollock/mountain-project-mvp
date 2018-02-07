//
//  TicksViewDataProcessorTests.swift
//  MountainProjectDemoAppTests
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import MountainProjectDemoApp

class TicksViewDataProcessorTests: XCTestCase {
    let processor = TicksViewDataProcessor()

    // MARK - tickDetails
    
    func testTickDetails_none() {
        let leadStyle = ""
        let sendStyle = ""
        let tick = Tick(date: "", routeId: 0, pitches: 0, leadStyle: leadStyle)
        let route = Route(id: 0, name: "", type: sendStyle)
        let result = processor.tickDetails(from: tick, with: route)
        XCTAssertNil(result)
    }
    
    func testTickDetails_noRoute() {
        let routeStyle = ""
        let sendStyle = "Lead"
        let tick = Tick(date: "", routeId: 0, pitches: 0, leadStyle: sendStyle)
        let route = Route(id: 0, name: "", type: routeStyle)
        let result = processor.tickDetails(from: tick, with: route)
        
        let expected = "Send Style: \(sendStyle)"
        XCTAssertEqual(result, expected)
    }
    
    func testTickDetails_noSend() {
        let routeStyle = "Trad"
        let sendStyle = ""
        let tick = Tick(date: "", routeId: 0, pitches: 0, leadStyle: sendStyle)
        let route = Route(id: 0, name: "", type: routeStyle)
        let result = processor.tickDetails(from: tick, with: route)
        
        let expected = "Route Style: \(routeStyle)"
        XCTAssertEqual(result, expected)
    }
    
    func testTickDetails_both() {
        let routeStyle = "Sport"
        let sendStyle = "TR"
        let tick = Tick(date: "", routeId: 0, pitches: 0, leadStyle: sendStyle)
        let route = Route(id: 0, name: "", type: routeStyle)
        let result = processor.tickDetails(from: tick, with: route)
        
        let expected = "Route Style: \(routeStyle), Send Style: \(sendStyle)"
        XCTAssertEqual(result, expected)
    }
}
