//
//  SomeEndpoint.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//
//  Some endpoint struct, in this case it's a public API from nasa gov to retrieve some picture data

import Foundation

struct SomeEndpoint: EndPointType {
    var baseURL: String {
        return "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var requestType: RequestType {
        return .service
    }
    
    var bodyEncoding: HTTPBodyEncoding {
        return .none
    }
    
    var jsonBody: Parameters {
        return Parameters()
    }
    
    var urlBody: [String : Any] {
        get {
            return [:]
        }
        set {
            
        }
    }
    
    var headers: [String : String] {
        return [String: String]()
    }
}
