//
//  UITestsAddContactView.swift
//  ContactProjectUITests
//
//  Created by jeevan tiwari on 19/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest

class UITestsAddContactView: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Test if alret is presented when try to insert empty contact
    func testAddEmptyContact() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addContactNavigationBar = app.navigationBars["Contact"]
        let doneButton = addContactNavigationBar.buttons["Done"]
        doneButton.tap()
        
        let alertsQuery = app.otherElements["CustomAlert"]
        XCTAssertTrue(alertsQuery.exists, "No alert present when all field are empty.")
    }
    
    //MARK: Test all elements of add contact view controller is exists
    func testAddContactElementsExistence() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()

        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_0")
        XCTAssertTrue(firstNameCell.exists, "First name table view cell not exists.")

        let lastNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_1")
        XCTAssertTrue(lastNameCell.exists, "Last name table view cell not exists.")

        let mobileCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_2")
        XCTAssertTrue(mobileCell.exists, "Mobile table view cell not exists.")

        let emailCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_3")
        XCTAssertTrue(emailCell.exists, "Email table view cell not exists.")

        let firstNamePlaceholder = firstNameCell.staticTexts["TableCellContactDetail_Label_Placeholder"]
        let firstNameTextField = firstNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(firstNamePlaceholder.exists, "First name placeholder not exists.")
        XCTAssertTrue(firstNameTextField.exists, "First name text field not exists.")

        let lastNamePlaceholder = firstNameCell.staticTexts["TableCellContactDetail_Label_Placeholder"]
        let lastNameTextField = lastNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(lastNamePlaceholder.exists, "First name placeholder not exists.")
        XCTAssertTrue(lastNameTextField.exists, "Last name text field not exists.")

        let mobileNamePlaceholder = firstNameCell.staticTexts["TableCellContactDetail_Label_Placeholder"]
        let mobileTextField = mobileCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(mobileNamePlaceholder.exists, "First name placeholder not exists.")
        XCTAssertTrue(mobileTextField.exists, "Mobile name text field not exists.")

        let emailPlaceholder = firstNameCell.staticTexts["TableCellContactDetail_Label_Placeholder"]
        let emailTextField = emailCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(emailPlaceholder.exists, "First name placeholder not exists.")
        XCTAssertTrue(emailTextField.exists, "Email name text field not exists.")
    }

    //Test all elements of add contact are not covered by any other view
    func testAddContactElementsHittable() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()

        let imagePhotoGallery = app.images["PROFILE_IMAGE_IDENTIFIER"]
        XCTAssertTrue(imagePhotoGallery.isHittable, "Select image not hittable.")

        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_0")
        XCTAssertTrue(firstNameCell.isHittable, "First name table view cell not hittable.")

        let lastNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_1")
        XCTAssertTrue(lastNameCell.isHittable, "Last name table view cell not hittable.")

        let mobileCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_2")
        XCTAssertTrue(mobileCell.isHittable, "Mobile table view cell not hittable.")

        let emailCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_3")
        XCTAssertTrue(emailCell.isHittable, "Email table view cell not hittable.")

        let firstNameTextField = firstNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(firstNameTextField.isHittable, "First name text field not hittable.")

        let lastNameTextField = lastNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(lastNameTextField.isHittable, "Last name text field not hittable.")

        let mobileTextField = mobileCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(mobileTextField.isHittable, "Mobile name text field not hittable.")

        let emailTextField = emailCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        XCTAssertTrue(emailTextField.isHittable, "Email name text field not hittable.")
    }

    //Test if all text field can become first responder and match the value after typing
    func testAddContactTextFieldEntry() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()

        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_0")
        XCTAssertTrue(firstNameCell.exists, "First name table view cell not exist.")

        let firstNameTextField = firstNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        firstNameTextField.tap()
        firstNameTextField.typeText("Jeevan")
        guard let firstName = firstNameTextField.value as? String else {
            XCTFail("Invalid first name.")
            return
        }
        XCTAssertTrue(firstName == "Jeevan", "Incorrect entry in first name field")

        let lastNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_1")
        let lastNameTextField = lastNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        lastNameTextField.tap()
        lastNameTextField.typeText("Tiwari")
        guard let lastName = lastNameTextField.value as? String else {
            XCTFail("Invalid last name.")
            return
        }
        XCTAssertTrue(lastName == "Tiwari", "Incorrect entry in last name field")

        let mobileCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_2")
        let mobileTextField = mobileCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        mobileTextField.tap()
        mobileTextField.typeText("9045152406")
        guard let mobileNumber = mobileTextField.value as? String else {
            XCTFail("Invalid mobile number.")
            return
        }
        XCTAssertTrue(mobileNumber == "9045152406", "Incorrect entry in mobile field")

        let emailCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_3")
        let emailTextField = emailCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        emailTextField.tap()
        emailTextField.typeText("jeewant857@gmail.com")
        guard let email = emailTextField.value as? String else {
            XCTFail("Invalid email.")
            return
        }
        XCTAssertTrue(email == "jeewant857@gmail.com", "Incorrect entry in email field")
    }
    
    //MARK: TEST ADD CONTACT
    func testAddContact() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()

        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_0")
        XCTAssertTrue(firstNameCell.exists, "First name table view cell not exist.")

        let firstNameTextField = firstNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        firstNameTextField.tap()
        firstNameTextField.typeText("Jeevan")
        guard let firstName = firstNameTextField.value as? String else {
            XCTFail("Invalid first name.")
            return
        }
        XCTAssertTrue(firstName == "Jeevan", "Incorrect entry in first name field")

        let lastNameCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_1")
        let lastNameTextField = lastNameCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        lastNameTextField.tap()
        lastNameTextField.typeText("Tiwari")
        guard let lastName = lastNameTextField.value as? String else {
            XCTFail("Invalid last name.")
            return
        }
        XCTAssertTrue(lastName == "Tiwari", "Incorrect entry in last name field")

        let mobileCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_2")
        let mobileTextField = mobileCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        mobileTextField.tap()
        mobileTextField.typeText("9045152406")
        guard let mobileNumber = mobileTextField.value as? String else {
            XCTFail("Invalid mobile number.")
            return
        }
        XCTAssertTrue(mobileNumber == "9045152406", "Incorrect entry in mobile field")

        let emailCell = table.cells.element(matching: .cell, identifier: "TableCellContactDetail_0_3")
        let emailTextField = emailCell.textFields["TableCellContactDetail_TextField_FieldValue"]
        emailTextField.tap()
        emailTextField.typeText("jeewant857@gmail.com")
        guard let email = emailTextField.value as? String else {
            XCTFail("Invalid email.")
            return
        }
    
        XCTAssertTrue(email == "jeewant857@gmail.com", "Incorrect entry in email field")
        
        let addContactNavigationBar = app.navigationBars["Contact"]
        let doneButton = addContactNavigationBar.buttons["Done"]
        doneButton.tap()
        
        let alertsQuery = app.otherElements["CustomAlert"]
        XCTAssertTrue(alertsQuery.exists, "No alert present when contact added.")
     //   self.waitForExpectations(timeout: 10.0, handler: nil)
        
    }
}

