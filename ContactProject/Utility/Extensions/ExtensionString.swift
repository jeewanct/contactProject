//
//  ExtensionString.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

extension String{
    
    var telURL: URL? {
        return URL(string: String(format: "tel://%@", self))
    }
    
    var messageURL: URL? {
        return URL(string: String(format: "sms://%@", self))
    }
    
    var mailURL: URL? {
        return URL(string: String(format: "mailto://%@", self))
    }
    
    var isPhone: String?{
        if self.count != 10 || Int(self) == nil{
            return "Please enter a vailid mobile number. Mobile number should be of 10 digits or more."
        }
        return nil
    }
    
    var isEmail: String?{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailPredicate.evaluate(with: self) {
            return "Please enter a valid email."
        }
        return nil
    }
    
    func isValidString(fieldValue: String?,fieldName: String = "", minLength: Int) -> String?{
        if fieldValue == nil || fieldValue == ""{
            return "Please enter \(fieldName)."
        }
        
        if fieldValue!.count < 2{
         return "\(fieldName) is too short (minimum is \(minLength) characters)"
        }
        return nil
    }
  
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    
    
}
