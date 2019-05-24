//
//  HomeScreenInteractor.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//

import Foundation

final class HomeScreenInteractor: HomeInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter:HomePresenterProtocol?
    
    // MARK: - Methods
    
    /// Get data from a network request
    /// - Parameters:
    ///     - endpointType: the endpoint type struct the network request is going handle with
    ///     - completionHandler: the response that will come back from the network request
    func getApodData(_ endpointType: EndPointType, _ completionHandler: @escaping ([NasaPlanetary.ApodModel]?, Error?) -> Void) {
        
        let networkRequest = NetworkRequest(URLSession.shared)
        networkRequest.request(endpointType) { (data, response, error) in
            
            guard let rawData = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let jsonData = try decoder.decode(NasaPlanetary.self, from: rawData)
                
                // send data back on main thread, to update UI
                DispatchQueue.main.async {
                    completionHandler(jsonData.data, nil)
                }
            } catch (let error) {
                completionHandler(nil, error)
            }
        }
    }
}
