//
//  TestsEditContact.swift
//  ContactProjectTests
//
//  Created by jeevan tiwari on 19/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest
@testable import ContactProject

class TestsEditContact: XCTestCase {
    
    var addContactViewModel: AddContactViewModel!
    
    override func setUp() {
        addContactViewModel = AddContactViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        addContactViewModel = nil
    }
    
    func testCancelBarButtonTitle() {
        XCTAssert(addContactViewModel.titleCancel == "Cancel", "Cancel button title mismatch.")
    }
    
    func testDoneBarButtonTitle() {
        XCTAssert(addContactViewModel.titleDone == "Done", "Done button title mismatch.")
    }
    
    func testCheckEmptyFields(){
        
        XCTAssert(addContactViewModel.isvalidateContact(contact: DummyContact.getIncomplete()) == false, "Validation failed")
        
    }
    
    func testAddContact(){
        let expectation = self.expectation(description: "Contact added succesfully.")
        let contact = DummyContact.getComplete()
        addContactViewModel.addedContact = { responseContact in
            if responseContact != nil{
                self.addContactViewModel.contact = responseContact!
                expectation.fulfill()
            }
        }
        addContactViewModel.showErrorAlert = { error in
            XCTAssert(error != nil, error!)
        }
        addContactViewModel.syncContact(contact: contact)
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testEditContact(){
        testAddContact()
        let expectation = self.expectation(description: "Contact edited succesfully.")
        
        addContactViewModel.from = .edit
        addContactViewModel.contact?.firstName = "Rajesh"
        
        addContactViewModel.addedContact = { responseContact in
            if responseContact != nil{
                expectation.fulfill()
            }
        }
        addContactViewModel.showErrorAlert = { error in
            XCTAssert(error != nil, error!)
        }
        //Editing first Name
        
        addContactViewModel.syncContact(contact: addContactViewModel.contact!)
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
    }

}


