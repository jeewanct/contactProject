//
//  ContactListModel.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation

struct ContactListModel{
    
    var contacts: [Contact]?
    var contactsGeneric: GenericSections?
    var showAlert: ShowAlertMessage?
    var showHud: ShowHud?
    
    func getContest(){
        let contacts = ContactRepository.getContacts
        HTTPClient.shared.dataTask(contacts) { (result: Result< [Contact]?, NetworkError>) in
            switch result{
            case .success(let contactList):
                
                let contactsSorted = Contact.setup(contacts: contactList ?? [Contact]())
                var genericSections = [GenericTableSection]()
                
                contactsSorted.forEach { (value) in
                    var genericRows = [GenericTableRows]()
                    var firstKey = ""
                    value.forEach { (contact) in
                        firstKey = String(contact.firstName?.first ?? " ")
                        genericRows.append(GenericTableRows(tableCell: TableCellContactList.self, rowData: contact))
                    }
                    let genericSection = GenericTableSection(sectionData: firstKey, tableRows: genericRows)
                    genericSections.append(genericSection)
                }
                self.contactsGeneric?(genericSections)
            case .failure(let error):
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
}

