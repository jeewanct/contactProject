//
//  ExtensionUIViewController.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 15/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit
import MBProgressHUD
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
    
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showHud(show: Bool){
        if show{
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func transparentNavigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3179999888, green: 0.8899999857, blue: 0.7609999776, alpha: 1)
    }
    
    func showAlert(message: String?){
        let alert: CustomAlert = UIView.fromNib()
        
        let messageHeight = message?.height(withConstrainedWidth: Constants.screenWidth - 32, font: alert.lblMessage.font) ?? 0
        alert.message = message
        let window: UIWindow?
        
        if #available(iOS 13.0, *){
            window = SceneDelegate.shared.window
        }else{
            window = UIApplication.shared.keyWindow
        }
        
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        alert.frame = CGRect(x: 16, y: topPadding, width: Constants.screenWidth - 32, height: messageHeight + 32)
        alert.transform = CGAffineTransform(translationX: 0, y: -120)
        self.view.addSubview(alert)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            alert.transform = .identity
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
                    alert.transform = CGAffineTransform(translationX: 0, y: -120)
                }) { (value) in
                    alert.removeFromSuperview()
                }
            }
        }
    }
    
   
    func fullName(firstName: String? , lastName: String?) -> String{
        (firstName ?? "") + " " + (lastName ?? "")
    }
    
}



