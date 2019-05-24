//
//  EndPointType.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var bodyEncoding: HTTPBodyEncoding { get }
    var requestType: RequestType { get }
    var jsonBody: Parameters { get }
    var urlBody: [String:Any] { get set }
    var headers: [String: String] { get }
}

enum RequestType {
    case service
}

// JSON body to encode once building the network request
public struct Parameters: Codable {
    
}
