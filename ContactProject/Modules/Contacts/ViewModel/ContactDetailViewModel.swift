//
//  ContactDetailViewModel.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

enum ContactDetailEnum: String{
    case Message
    case Call
    case Email
    case Favourite
}

class ContactDetailViewModel{
    typealias communicationUrl = (URL) -> Void
    
    var genericSectionsCollection: GenericCollectionSections?
    var showHud: ShowHud?
    var genericSectionTable: GenericSections?
    var contact: Contact?
    var showAlert: ShowAlertMessage?
    var repository: ContactRepository!
    var contactUser: communicationUrl?
    var deletedSuccessfully = false
    
    func createViews(){
        //MARK: CREATE GENERIC SECTION FOR ABOVE VIEW
        let favoriteImage = contact?.favorite == true ?  #imageLiteral(resourceName: "favourite_button_selected") : #imageLiteral(resourceName: "favourite_button")
        let collectionDetails = [
            ContactCollectionDetails(#imageLiteral(resourceName: "message_button"), ContactDetailEnum.Message.rawValue),
            ContactCollectionDetails(#imageLiteral(resourceName: "call_button.png"), ContactDetailEnum.Call.rawValue),
            ContactCollectionDetails(#imageLiteral(resourceName: "email_button"), ContactDetailEnum.Email.rawValue),
            ContactCollectionDetails(favoriteImage, ContactDetailEnum.Favourite.rawValue),
        ]
        let itemSize = CGSize(width: (Constants.screenWidth * 0.8 ) / 4, height: 70)
        let genericRows = collectionDetails.map({GenericCollectionRows(collectionCell: CollectionCellDetails.self, rowData: $0, itemSize: itemSize)})
        let genericSection = [GenericCollectionSection(collectionRows: genericRows)]
        
        genericSectionsCollection?(genericSection)
        createUserDetails()
    }
    
    func createUserDetails(){
        //MARK: CREATE GENERIC SECTION FOR BELOW VIEW
        let contactInfo = [
            ContactDetailsInfo("Mobile", contact?.phoneNumber),
            ContactDetailsInfo("Email", contact?.email)
        ]
        let genericRowsTable = contactInfo.map({GenericTableRows(tableCell: TableCellContactDetail.self, rowData: $0)})
        
        let tableGenericSections = [GenericTableSection(tableRows: genericRowsTable)]
        genericSectionTable?(tableGenericSections)
    }
    
    
    func getContactDetails(){
        if let contactId = contact?.id{
            showHud?(true)
            repository = ContactRepository.getContact(id: Int(contactId))
            repository.getContactDetails(id: Int(contactId), completion: { [weak self] (contact) in
                self?.showHud?(false)
                self?.contact = contact
                self?.createUserDetails()
            }) { [weak self](error) in
                self?.showAlert?(error)
                self?.showHud?(false)
            }
        }else{
            showAlert?("Invalid User")
        }
    }
    
    func contactTo(_ index: Int){
        switch index {
        case 0:
            if let messageURL = contact?.phoneNumber?.messageURL, UIApplication.shared.canOpenURL(messageURL){
                contactUser?(messageURL)
            }else{
                showAlert?("Contact number not valid.")
            }
        case 1:
            if let phoneURL = contact?.phoneNumber?.telURL, UIApplication.shared.canOpenURL(phoneURL){
                contactUser?(phoneURL)
            }else{
                showAlert?("Contact number not valid.")
            }
        case 2:
            if let emailURL = contact?.email?.mailURL, UIApplication.shared.canOpenURL(emailURL){
                contactUser?(emailURL)
            }else{
                showAlert?("Contact email not valid.")
            }
        case 3:
            addAsFavorite()
        default:
            break
        }
    }
    
    func addAsFavorite(){
        self.showHud?(true)
        if let id = contact?.id{
            contact?.favorite = !(contact?.favorite ?? true)
            repository.updateContact(Int(id), contact!, completion: { [weak self](contact) in
                self?.showHud?(false)
                self?.contact = contact
                self?.createViews()
            }) { [weak self](error) in
               self?.showAlert?(error)
               self?.showHud?(false)
                self?.contact?.favorite = !(self?.contact?.favorite ?? true)
            }
        }else{
            showAlert?("Invalid User")
        }
    }
    
    func deleteContact(){
        self.showHud?(true)
        if let id = contact?.id{
            repository.deleteContact(id, completion: { [weak self](contact) in
                self?.deletedSuccessfully = true
                let message = (contact?.firstName ?? "") + " " + (contact?.lastName ?? "")
                self?.showAlert?(message)
                self?.showHud?(false)
            }) { [weak self](error) in
                self?.showAlert?(error)
                self?.showHud?(false)
            }
        }else{
            showAlert?("Invalid User")
        }
    }
}

