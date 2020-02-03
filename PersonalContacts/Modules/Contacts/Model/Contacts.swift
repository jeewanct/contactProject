//
//  Contacts.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation
 class Contact: Codable {
     var id: Int64?
     var lastName: String?
     var firstName: String?
     var profilePic: String?
     var favorite: Bool?
     var email: String?
     var phoneNumber: String?


    static func setup(contacts: [Contact]) -> [[Contact]]{
        let sortedContacts = contacts.sorted(by: { ($0.firstName ?? "") < ($1.firstName ?? "" ) }) // sort the Array first.
        print(sortedContacts)
        let groupedContacts = sortedContacts.reduce([[Contact]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.firstName!.first == $1.firstName!.first {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                collection += [[$1]]
            }
            return collection
        }
        
        return groupedContacts
    }
}

