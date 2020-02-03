//
//  URLResponseExtension.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//
import Foundation

extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}
