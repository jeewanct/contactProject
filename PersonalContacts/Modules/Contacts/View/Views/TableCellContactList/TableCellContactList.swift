//
//  TableCellContactList.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
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
        imageContact.addImage(url: URL(string: Constants.Service.baseURL + (contactDetails.profilePic ?? "")),placeholderImage: #imageLiteral(resourceName: "placeholder_photo.png"))
        imageFavorite.isHidden = contactDetails.favorite ?? true
    }
}
