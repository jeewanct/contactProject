//
//  ContactListTests.swift
//  ContactProjectTests
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import XCTest

@testable import ContactProject

class ContactListTests: XCTestCase {

    var contactListViewModel: ContactListViewModel!
    
    override func setUp() {
        contactListViewModel = ContactListViewModel()
    }

    override func tearDown() {
        contactListViewModel = nil
    }

    func testContactListTitle() {
        XCTAssert(contactListViewModel.title == "Contact", "Contact list title mismatch.")
    }
    

    func testContactsAPISuccessResponse() {
        let expectation = self.expectation(description: "No response recevice from contact list API.")
        
        contactListViewModel.showAlert = { alertMessage in
            XCTAssertTrue(alertMessage == nil, alertMessage!)
        }
        
        contactListViewModel.contactsGeneric = { genericContacts in
            expectation.fulfill()
        }
            
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testContactsAPIResultCount() {
        let expectation = self.expectation(description: "Invalid number of contact returns by contact list API.")
        
        contactListViewModel.showAlert = { alertMessage in
            XCTAssertTrue(alertMessage == nil, alertMessage!)
        }
        
        contactListViewModel.contactsGeneric = { genericContacts in
            if genericContacts.count > 1{
                expectation.fulfill()
            }
        }

        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}

