//
//  HomeScreenProtocols.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//
//
// All protocols served for the Viper architecture defined here in one file
// contains protocols to all components of the base structure
//
//

import UIKit
import Foundation

protocol HomePresenterProtocol: class {
    
    var interactor: HomeInteractorProtocol? { get set }
    
    func fetchData()
    func prepareDataForUI(_ apodData: [NasaPlanetary.ApodModel])
}

protocol HomeInteractorProtocol {
    
    var presenter:HomePresenterProtocol? { get set }
    
    func getApodData(_ endpointType: EndPointType, _ completionHandler: @escaping ([NasaPlanetary.ApodModel]?, Error?) -> Void)
}
