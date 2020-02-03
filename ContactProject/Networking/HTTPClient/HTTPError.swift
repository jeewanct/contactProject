//
//  HTTPError.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation

typealias ONERROR = (NetworkError?) -> Void

enum Errors: String{
    case JSONDecodingError = "Something went wrong. Try after sometime."
}


struct NetworkError: Error {
    var localizedDescription: String
    
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}
