//
//  ContactRepository.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation


import Foundation
enum ContactRepository {
    case getContacts
    case getContact(id: Int)
    case deleteContact(id: Int)
    case addContact(contact: Contact)
    case updateContact(id: Int, contact: Contact)
}

extension ContactRepository: RequestProtocol {
    //Set Base URL
    var baseURL: URL {
        guard let url = URL(string: Constants.Service.baseURL) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }

    //Returns EndPoint for Contact APIs
    var path: String {
        switch self {
        case .getContacts, .addContact:
            return "contacts.json"
        case .getContact(let id), .deleteContact(let id), .updateContact(let id, _):
            return "contacts/\(String(describing: id)).json"
        }
    }

    //Returns HTTP Method for contact APIs
    var httpMethod: HTTPMethod {
        switch self {
        case .getContacts, .getContact:
            return .get
        case .addContact:
            return .post
        case .updateContact:
            return .put
        case .deleteContact:
            return .delete
        }
    }

    //Encode and Returns Encoded Data
   var httpBody: Data? {
        switch self {
        case .addContact(let contact),.updateContact(_, let contact):
            do {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
                return try jsonEncoder.encode(contact)
            } catch {
                Log.error("Unable to encode Contact.", error: error)
            }
        default:
            return nil
        }
        return nil
    }

    //Return Contact APIs Specific Headers
    var headers: HTTPHeaders? {
        return nil
    }
}

extension ContactRepository{
    
    func getContacts(completion: @escaping ([Contact]?) -> Void,onError: @escaping (String?) -> Void){
        
        HTTPClient.shared.dataTask(ContactRepository.self.getContacts) {(result: Result< [Contact]?, NetworkError>) in
            switch result{
            case .success(let contactList):
                completion(contactList)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    func getContactDetails(id: Int, completion: @escaping (Contact?) -> Void,onError: @escaping (String?) -> Void){
        HTTPClient.shared.dataTask(ContactRepository.self.getContact(id: id)) { (result: Result<Contact?, NetworkError>) in
            switch result{
            case .success(let contactDetails):
                completion(contactDetails)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    func addContact(contact: Contact,completion: @escaping (Contact?) -> Void,onError: @escaping (String?) -> Void){
        
        HTTPClient.shared.dataTask(self) { (result: Result<Contact?, NetworkError>) in
            switch result{
            case .success(let addedContact):
                completion(addedContact)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    func updateContact(_ id: Int, _ contact: Contact, completion: @escaping (Contact?) -> Void,onError: @escaping (String?) -> Void){
        HTTPClient.shared.dataTask(ContactRepository.self.updateContact(id: id, contact: contact)) { (result: Result< Contact?, NetworkError>) in
            switch result{
            case .success(let contact):
                completion(contact)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    
    func deleteContact(_ id: Int,completion: @escaping (Contact?) -> Void,onError: @escaping (String?) -> Void){
        HTTPClient.shared.dataTask(ContactRepository.self.deleteContact(id: id)) { (result: Result< Contact?, NetworkError>) in
            switch result{
            case .success(let deletedContact):
                completion(deletedContact)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
}
