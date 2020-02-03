//
//  NavigationTestAddContact.swift
//  ContactProjectUITests
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest

class NavigationTestAddContact: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddContactNavigationBar() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addContactNavigationBar = app.navigationBars["Contact"]
        
        let cancelButton = addContactNavigationBar.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists, "Cancel button not exists in add contact navigation bar.")
        
        let doneButton = addContactNavigationBar.buttons["Done"]
        XCTAssertTrue(doneButton.exists, "Done button not exists in add contact navigation bar.")
    }
    
    func testAddContactNavigationBarCancelButtonAction() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addContactNavigationBar = app.navigationBars["Contact"]
        
        let cancelButton = addContactNavigationBar.buttons["Cancel"]
        cancelButton.tap()
        
        XCTAssertTrue(contactNavigationBar.isHittable, "Contact list navigation bar not exist after dismising the add contact view controller.")
    }
}
