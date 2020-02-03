//
//  UITestsContactDetail.swift
//  ContactProjectUITests
//
//  Created by jeevan tiwari on 19/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest

class UITestsContactDetail: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Test all elements of add contact view controller is exists
    func testAddContactElementsExistence() {
        tapContactListFirstCell()
        let collection = app.collectionViews.matching(identifier: "CONTACT_IDENTIFIER")
        let messageCell = collection.cells.element(matching: .cell, identifier: "CollectionCellDetails_0_0")
        XCTAssertTrue(messageCell.exists, "Message collection view cell not exists.")
        
        let callCell = collection.cells.element(matching: .cell, identifier: "CollectionCellDetails_0_1")
        XCTAssertTrue(callCell.exists, "Call collection view cell not exists.")
        
        let emailCell = collection.cells.element(matching: .cell, identifier: "CollectionCellDetails_0_2")
        XCTAssertTrue(emailCell.exists, "Email collection view cell not exists.")
        
        let favoriteCell = collection.cells.element(matching: .cell, identifier: "CollectionCellDetails_0_3")
        XCTAssertTrue(favoriteCell.exists, "Favorite collection view cell not exists.")
        
        let messageImage = messageCell.images["COLLECTIONCELLDETAILS_IMAGE_OPTION"]
        XCTAssert(messageImage.exists, "Message image not exist")
        let messageLabel = messageCell.staticTexts["COLLECTIONCELLDETAILS_LBL_OPTION"]
        XCTAssert(messageLabel.exists, "Message static text not exist")
        
        let callImage = messageCell.images["COLLECTIONCELLDETAILS_IMAGE_OPTION"]
        XCTAssert(callImage.exists, "Message image not exist")
        let callLabel = messageCell.staticTexts["COLLECTIONCELLDETAILS_LBL_OPTION"]
        XCTAssert(callLabel.exists, "Message static text not exist")
        
        let emailImage = messageCell.images["COLLECTIONCELLDETAILS_IMAGE_OPTION"]
        XCTAssert(emailImage.exists, "Message image not exist")
        let emailLabel = messageCell.staticTexts["COLLECTIONCELLDETAILS_LBL_OPTION"]
        XCTAssert(emailLabel.exists, "Message static text not exist")
        
        
        let favoriteImage = messageCell.images["COLLECTIONCELLDETAILS_IMAGE_OPTION"]
        XCTAssert(favoriteImage.exists, "Message image not exist")
        let favoriteLabel = messageCell.staticTexts["COLLECTIONCELLDETAILS_LBL_OPTION"]
        XCTAssert(favoriteLabel.exists, "Message static text not exist")
    }
    
    
    func testTapContactCallMessgeEmail(){
        tapContactListFirstCell()
        let collection = app.collectionViews.matching(identifier: "CONTACT_IDENTIFIER")
        let messageCell = collection.cells.element(matching: .cell, identifier: "CollectionCellDetails_0_0")
    
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: messageCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
        
        messageCell.tap()
        
        
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

