//
//  CustomAlert.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class CustomAlert: UIView {

    @IBOutlet weak var lblMessage: UILabel!
    
    var message: String?{
        didSet{
            lblMessage.text = message
        }
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

}
