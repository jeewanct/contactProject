//
//  CollectionCellDetails.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class CollectionCellDetails: BaseCollectionCell{
    
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var imageOption: UIImageView!
    
    override var data: Any?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        guard let contactDetails = data as? ContactCollectionDetails else { return }
        lblOption.text = contactDetails.placeholder
        imageOption.image = contactDetails.image
    }
}
