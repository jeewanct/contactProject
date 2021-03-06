//
//  NavigationFlow.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

//MARK: Get `Storyboard` names
enum Storyboard: String{
    case Contacts
}

//MARK: Get `Contacts` module from here
extension NSObject{
    var contactList: ContactListView{
        let contactList: ContactListView = UIViewController.loadController(storyBoardName: Storyboard.Contacts.rawValue)
        return contactList
    }
    
    var contactDetail: ContactDetailView{
        let contactDetail: ContactDetailView = UIViewController.loadController(storyBoardName: Storyboard.Contacts.rawValue)
        return contactDetail
    }
    
    var addContact: AddContactView{
        let addContact: AddContactView = UIViewController.loadController(storyBoardName: Storyboard.Contacts.rawValue)
        return addContact
    }
}

