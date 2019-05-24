//
//  HTTPMethod.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum HTTPBodyEncoding {
    case json
    case url
    case utf8
    case none
}
