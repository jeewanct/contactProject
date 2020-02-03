//
//  ExtensionUIImageView.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    func addImage(url: URL?, placeholderImage: UIImage = #imageLiteral(resourceName: "ImageAdd")){
        self.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
}
