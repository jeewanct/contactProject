//
//  AddContactViewModel.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation

class AddContactViewModel{
    
    typealias ContactAdded = (Contact?) -> Void
    var showErrorAlert: ShowAlertMessage?
    var showHud: ShowHud?
    var addedContact: ContactAdded?
    var repository: ContactRepository!
    let titleCancel = "Cancel"
    let titleDone = "Done"
    var contact: Contact?
    var from: AddEditContactEnum = .add
    
    var contactDetails = [ContactDetailsInfo]()
    
    var genericTable: GenericSections?
    
    func createView(){
        contactDetails = [
            ContactDetailsInfo("First Name", contact?.firstName),
            ContactDetailsInfo("Last Name", contact?.lastName),
            ContactDetailsInfo("Mobile", contact?.phoneNumber),
            ContactDetailsInfo("Email", contact?.email),
        ]
        let genericRows = contactDetails.map({GenericTableRows(tableCell: TableCellContactDetail.self, rowData: $0)})
        let genericSection = [GenericTableSection(tableRows: genericRows)]
        genericTable?(genericSection)
    }
    
    func addContact(){
        let contact = Contact()
        contact.id =        self.contact?.id
        contact.favorite =  self.contact?.favorite
        contact.firstName   = contactDetails[0].fieldValue
        contact.lastName    = contactDetails[1].fieldValue
        contact.phoneNumber    = contactDetails[2].fieldValue
        contact.email    = contactDetails[3].fieldValue
        
        if isvalidateContact(contact: contact){
            syncContact(contact: contact)
        }
    }
    
    func isvalidateContact(contact: Contact) -> Bool {
        if let invalidFirstName = "".isValidString(fieldValue: contact.firstName, fieldName: "First Name", minLength: 2){
            showErrorAlert?(invalidFirstName)
            return false
        }else if let invalidSecondName = "".isValidString(fieldValue: contact.lastName, fieldName: "Last Name", minLength: 2){
            showErrorAlert?(invalidSecondName)
            return false
        }else if let invalidPhone = (contact.phoneNumber ?? "").isPhone{
            showErrorAlert?(invalidPhone)
            return false
        }else if let invalidEmail = (contact.email ?? "").isEmail{
            showErrorAlert?(invalidEmail)
            return false
        }
        return true
    }
    
    func syncContact(contact: Contact){
        
        if from == .add{
            self.showHud?(true)
            repository = ContactRepository.addContact(contact: contact)
            repository.addContact(contact: contact, completion: { [weak self](contact) in
                self?.addedContact?(contact)
                self?.showHud?(false)
            }) { [weak self](error) in
                self?.showErrorAlert?(error)
                self?.showHud?(false)
            }
        }else{
            
            if let id = contact.id{
                self.showHud?(true)
                repository = ContactRepository.updateContact(id: Int(id), contact: contact)
                repository.addContact(contact: contact, completion: { [weak self](contact) in
                    self?.addedContact?(contact)
                    self?.showHud?(false)
                }) { [weak self](error) in
                    self?.showErrorAlert?(error)
                    self?.showHud?(false)
                }
            }else{
                showErrorAlert?("Invalid user")
            }
        }
    }
}
