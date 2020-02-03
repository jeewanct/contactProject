//
//  RequestProtocol.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders? { get }
}
