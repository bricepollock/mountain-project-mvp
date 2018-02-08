//
//  UserViewDataProcessor.swift
//  MountainProjectDemoAppTests
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import MountainProjectDemoApp

class UserViewDataProcessorTests: XCTestCase {
    let processor = UserViewDataProcessor()
    
    let emptyTickResponse = TickResponse(ticks: [])
    
    /// MARK - textFromStyleDetail
    
    func testTextFromStyle_empty() {
        let detail = StyleDetail(lead: "", follow: "")
        let result = processor.textFromStyleDetail(detail: detail)
        let expected: String? = nil
        XCTAssertEqual(result, expected)
    }
    
    func testTextFromStyle_lead() {
        let detail = StyleDetail(lead: "a", follow: "")
        let result = processor.textFromStyleDetail(detail: detail)
        let expected = "Lead: a"
        XCTAssertEqual(result, expected)
    }
    
    func testTextFromStyle_follow() {
        let detail = StyleDetail(lead: "", follow: "b")
        let result = processor.textFromStyleDetail(detail: detail)
        let expected = "Follow: b"
        XCTAssertEqual(result, expected)
    }
    
    func testTextFromStyle_both() {
        let detail = StyleDetail(lead: "a", follow: "b")
        let result = processor.textFromStyleDetail(detail: detail)
        let expected = "Lead: a, Follow: b"
        XCTAssertEqual(result, expected)
    }
    
    // MARK - createStyleData
    
    func testCreateStyleData_empty() {
        let user = User(name: "asdf", styles: [:])
        let result = processor.createStyleData(from: user, with: emptyTickResponse, with: [:])
        XCTAssertTrue(result.isEmpty)
    }
    
    func testCreateStyleData_oneValid() {
        let user = User(name: "asdf", styles: [
            "Trad": StyleDetail(lead: "a", follow: "b")
            ]
        )
        let result = processor.createStyleData(from: user, with: emptyTickResponse, with: [:])
        XCTAssertEqual(result.count, 1)
    }
    
    func testCreateStyleData_twoValid() {
        let user = User(name: "asdf", styles: [
            "Trad": StyleDetail(lead: "", follow: "b"),
            "Sport": StyleDetail(lead: "a", follow: "")
            ]
        )
        let result = processor.createStyleData(from: user, with: emptyTickResponse, with: [:])
        XCTAssertEqual(result.count, 2)
    }
    
    func testCreateStyleData_two_oneInValid() {
        let validStyle = "Trad"
        let user = User(name: "asdf", styles: [
            validStyle: StyleDetail(lead: "a", follow: "b"),
            "Sport": StyleDetail(lead: "", follow: "")
            ]
        )
        let result = processor.createStyleData(from: user, with: emptyTickResponse, with: [:])
        XCTAssertFalse(result.isEmpty)
        XCTAssert(result.first?.styleText == validStyle)
    }
    
    // MARK - count
    
    func testCount_empty_all() {
        let style = "Trad"
        let response = TickResponse(ticks: [])
        let routeMap = [Int: Route]()
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 0
        XCTAssertEqual(result, expected)
    }
    
    func testCount_empty_routes() {
        let style = "Trad"
        let response = TickResponse(ticks: [
            Tick(date: "", routeId: 1, pitches: 0, leadStyle: "")
            ]
        )
        let routeMap = [Int: Route]()
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 0
        XCTAssertEqual(result, expected)
    }
    
    func testCount_empty_response() {
        let style = "Trad"
        let response = TickResponse(ticks: [])
        let routeMap = [
            1 : Route(id: 1, name: "", type: style)
        ]
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 0
        XCTAssertEqual(result, expected)
    }
    
    func testCount_one() {
        let style = "Trad"
        let routeId = 1
        let response = TickResponse(ticks: [
            Tick(date: "", routeId: routeId, pitches: 0, leadStyle: "")
            ]
        )
        let routeMap = [
            routeId : Route(id: routeId, name: "", type: style)
        ]
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 1
        XCTAssertEqual(result, expected)
    }
    
    func testCount_oneMatch() {
        let style = "Trad"
        let routeId = 1
        let response = TickResponse(ticks: [
            Tick(date: "", routeId: routeId, pitches: 0, leadStyle: ""),
            Tick(date: "", routeId: 2, pitches: 0, leadStyle: "")
            ]
        )
        let routeMap = [
            routeId : Route(id: routeId, name: "", type: style),
            2 : Route(id: 2, name: "", type: "Sport")
        ]
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 1
        XCTAssertEqual(result, expected)
    }
    
    func testCount_two() {
        let style = "Trad"
        let routeId = 1
        let routeIdSecond = 3
        let response = TickResponse(ticks: [
            Tick(date: "", routeId: routeId, pitches: 0, leadStyle: ""),
            Tick(date: "", routeId: 2, pitches: 0, leadStyle: ""),
            Tick(date: "", routeId: routeIdSecond, pitches: 0, leadStyle: "")
            ]
        )
        let routeMap = [
            routeId : Route(id: routeId, name: "", type: style),
            2 : Route(id: 2, name: "", type: "Sport"),
            routeIdSecond : Route(id: routeIdSecond, name: "", type: style)
        ]
        let result = processor.findTicks(for: style, given: response, with: routeMap).count
        
        let expected = 2
        XCTAssertEqual(result, expected)
    }


}
