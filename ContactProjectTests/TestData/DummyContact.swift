//
//  DummyContact.swift
//  ContactProjectTests
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation


@testable import ContactProject

struct DummyContact {
    static func getEmpty() -> Contact{
        let contact = Contact()
        return contact
    }
    
    static func getIncomplete() -> Contact {
        let contact = getEmpty()
        contact.id = 1
        contact.firstName = "Jeevan"
        contact.lastName = "Tiwari"
        contact.profilePic = "image.png"
        contact.favorite = false
        return contact
    }
    
    static func getComplete() -> Contact {
        let contact = getIncomplete()
        contact.phoneNumber = "+919045152406"
        contact.email = "jeewant857@gmail.com"
        return contact
    }
}
