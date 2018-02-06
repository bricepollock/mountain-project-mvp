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
        let result = processor.createStyleData(from: user)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testCreateStyleData_oneValid() {
        let user = User(name: "asdf", styles: [
            "Trad": StyleDetail(lead: "a", follow: "b")
            ]
        )
        let result = processor.createStyleData(from: user)
        XCTAssertEqual(result.count, 1)
    }
    
    func testCreateStyleData_twoValid() {
        let user = User(name: "asdf", styles: [
            "Trad": StyleDetail(lead: "", follow: "b"),
            "Sport": StyleDetail(lead: "a", follow: "")
            ]
        )
        let result = processor.createStyleData(from: user)
        XCTAssertEqual(result.count, 2)
    }
    
    func testCreateStyleData_two_oneInValid() {
        let validStyle = "Trad"
        let user = User(name: "asdf", styles: [
            validStyle: StyleDetail(lead: "a", follow: "b"),
            "Sport": StyleDetail(lead: "", follow: "")
            ]
        )
        let result = processor.createStyleData(from: user)
        XCTAssertFalse(result.isEmpty)
        XCTAssert(result.first?.styleText == validStyle)
    }
    
}
