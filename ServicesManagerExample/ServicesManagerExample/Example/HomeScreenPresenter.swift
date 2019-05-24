//
//  HomeScreenPresenter.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//
//  The presenter contains methods to notify interactor the view is loaded initially,
//  also method to send data back to view

import Foundation
import UIKit

enum EndpointUrls: String {
    case SomeDataForScreen
    
    func getEndpointType() -> EndPointType {
        switch self {
        case .SomeDataForScreen:
            return SomeEndpoint()
        }
    }
}

final class HomeScreenPresenter: HomePresenterProtocol {
    
    // MARK: - Properties
    var interactor: HomeInteractorProtocol?
    
    // MARK: - Methods
    
    /// Fetch data from server
    func fetchData() {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        // request data
        self.interactor?.getApodData(EndpointUrls.SomeDataForScreen.getEndpointType(), { [weak self] (data, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            // guarding self capture
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("HomeScreenPresenter: getApodData() response: \(error.localizedDescription)")
            }
            
            guard let allData = data
                else {
                    print("HomeScreenPresenter: getApodData() No valid data")
                    return
            }
            
            strongSelf.prepareDataForUI(allData)
            
        })
    }
    
    func prepareDataForUI(_ apodData: [NasaPlanetary.ApodModel]) {
        
        // process data and present them to view
    }
    
}
