//
//  ContactDetailViewModel.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

struct ContactDetailViewModel{
    
    var genericSections: GenericCollectionSections?
    var contact: Contact!
    
    func createViews(){
        let collectionDetails = [
            ContactCollectionDetails(#imageLiteral(resourceName: "message_button"), "Message"),
            ContactCollectionDetails(#imageLiteral(resourceName: "call_button.png"), "Call"),
            ContactCollectionDetails(#imageLiteral(resourceName: "email_button"), "Email"),
            ContactCollectionDetails(#imageLiteral(resourceName: "favourite_button_selected"), "Favourite"),
        ]
        let itemSize = CGSize(width: (Constants.screenWidth * 0.8 ) / 4, height: 70)
        let genericRows = collectionDetails.map({GenericCollectionRows(collectionCell: CollectionCellDetails.self, rowData: $0, itemSize: itemSize)})
        let genericSection = [GenericCollectionSection(collectionRows: genericRows)]
        genericSections?(genericSection)
    }
    
    
}
