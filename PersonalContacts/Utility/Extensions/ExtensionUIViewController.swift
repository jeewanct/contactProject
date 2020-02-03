//
//  ExtensionUIViewController.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 15/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

extension UIViewController{
    class func loadController<T: UIViewController>(storyBoardName: String) -> T{
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    func push(controller: UIViewController){
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func present(controller: UIViewController){
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
}



