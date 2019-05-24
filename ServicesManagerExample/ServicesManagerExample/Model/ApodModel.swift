//
//  ApodModel.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//

import Foundation

/*
 The struct here is responsible to store and collect data
 */
public struct NasaPlanetary: Decodable {
    
    struct ApodModel: Decodable {
        var date: String?
        var explanation: String?
        var url: String?
    }
    
    var data: [ApodModel]
}
