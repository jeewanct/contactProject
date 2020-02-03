//
//  ContactDetails.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class ContactCollectionDetails{
    var image: UIImage
    var placeholder: String
    var isFavorite: Bool
    
    init(_ image: UIImage,_ placeholder: String, isFavorite: Bool = false) {
        self.image = image
        self.placeholder = placeholder
        self.isFavorite = isFavorite
    }
}

class ContactDetailsInfo{
    var placeholder: String?
    var fieldValue: String?
    var isEditable: Bool
    init(_ placeholder: String?,_ fieldValue: String? = nil, isEditable: Bool = true) {
        self.fieldValue = fieldValue
        self.placeholder = placeholder
        self.isEditable = isEditable
    }
    
}
