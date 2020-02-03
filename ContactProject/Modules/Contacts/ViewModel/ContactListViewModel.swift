//
//  ContactListModel.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//


import Foundation

class  ContactListViewModel{
    typealias ContactDetail = (Contact?) -> Void
    
    var contacts: [[Contact]]?
    var contactsGeneric: GenericSections?
    var showAlert: ShowAlertMessage?
    var showHud: ShowHud?
    var repository = ContactRepository.getContacts
    var contactDetails: ContactDetail?
    
    let title = "Contact"
    
    func getContacts(){
        showHud?(true)
        repository.getContacts(completion: { [weak self](contactList) in
            self?.showHud?(false)
            let contactsSorted = Contact.setup(contacts: contactList ?? [Contact]())
            self?.contacts = contactsSorted
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
            self?.contactsGeneric?(genericSections)
        }) { [weak self](error) in
            self?.showHud?(false)
            self?.showAlert?(error ?? "")
        }
    }
    
    func jumpToContact(_ section: Int, _ item: Int){
        contactDetails?(contacts?[section][item])
    }
    
   
}


