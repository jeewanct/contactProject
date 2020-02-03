//
//  SceneDelegate.swift
//  ContactProject
//
//  Created by jeevan tiwari on 18/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//


import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static var shared: SceneDelegate!
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController =  UINavigationController(rootViewController: contactList)
        window?.makeKeyAndVisible()
        SceneDelegate.shared = self
        IQKeyboardManager.shared.enable = true
    }
}

