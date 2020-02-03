//
//  TableCellContactList.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class TableCellContactList: BaseTableCell {

    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var imageFavorite: UIImageView!
    override var data: Any?{
        didSet{
            setup()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(){
        guard let contactDetails = data as? Contact else { return }
        lblContactName.text = (contactDetails.firstName ?? "") + " " + (contactDetails.lastName ?? "")
        imageContact.addImage(urlString: contactDetails.profilePic, placeholderImage: #imageLiteral(resourceName: "placeholder_photo.png") )
        imageFavorite.isHidden = !(contactDetails.favorite ?? false)
    }
}

