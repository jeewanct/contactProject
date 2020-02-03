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
    func addImage(urlString: String?, placeholderImage: UIImage = #imageLiteral(resourceName: "ImageAdd")){
        let completeUrlString = Constants.Service.baseURL + (urlString ?? "")
        let url = URL(string: completeUrlString)
        self.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
}
