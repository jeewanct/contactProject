//
//  Bindable.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 15/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import UIKit

class Bindable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
