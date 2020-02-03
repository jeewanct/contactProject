//
//  NavigationTestContactDetails.swift
//  ContactProjectUITests
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest

class NavigationTestContactDetail: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContactDetailsNavigation() {
        tapContactListFirstCell()
        
        let contactNavigationBar = app.navigationBars["Contact"]
        let backButton = contactNavigationBar.buttons["Contact"]
        XCTAssertTrue(backButton.exists, "Back button not exist in navigation bar.")
        
        let editButton = contactNavigationBar.buttons["Edit"]
        XCTAssertTrue(editButton.exists, "Back button not exist in navigation bar.")
    }
    
    func testContactEditNavigationFromContactDetails() {
        tapContactListFirstCell()
        let contactNavigationBar = app.navigationBars["Contact"]
        
        let editButton = contactNavigationBar.buttons["Edit"]
        XCTAssertTrue(editButton.exists, "Back button not exist in navigation bar.")
        
        editButton.tap()
        
        let editNavigationBar = app.navigationBars["Contact"]
        XCTAssertTrue(editNavigationBar.exists, "Edit navigation bar not exist.")
    }
    
    private func tapContactListFirstCell() {
        let myTable = app.tables.matching(identifier: "contactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "TableCellContactList_0_0")
        
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
        
        cell.tap()
    }

}

