//
//  NetworkRequest.swift
//  ServicesManagerExample
//
//  Created by Fabio Acri on 10/04/2019.
//  Copyright © 2019 Fabio Acri. All rights reserved.
//

import Foundation

public typealias NetworkRequestCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case failed = "Network request failed."
    case unableToParse = "We could not parse the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkRequestErrors: Error, Equatable {
    
    case invalidUrl
    case invalidNetworkRequest
    case invalidJSONObjectEncoding
    
    func errorMsg() -> String {
        switch self {
        case .invalidUrl:
            return "Invalid URL!"
        case .invalidNetworkRequest:
            return "Invalid network request!"
        case .invalidJSONObjectEncoding:
            return "Invalid JSON encoding"
        }
    }
    
    public static func == (lhs: NetworkRequestErrors, rhs: NetworkRequestErrors) -> Bool {
        return lhs.errorMsg() == rhs.errorMsg()
    }
}

protocol NetworkRequestProtocol {
    func request(_ endPoint: EndPointType, completion: @escaping NetworkRequestCompletion)
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}

// defining network session protocol
protocol NetworkSession {
    func loadData(_ request: URLRequest, completion: @escaping NetworkRequestCompletion)
}

// extending URLSession conforming to the above protocol so for mocking purposes
extension URLSession: NetworkSession {
    func loadData(_ request: URLRequest, completion: @escaping NetworkRequestCompletion) {
        dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        }).resume()
    }
}

final class NetworkRequest: NetworkRequestProtocol {
    
    // MARK: - Properties
    private var networkSession: NetworkSession
    
    // MARK: - Methods
    
    init(_ networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    func request(_ endPoint: EndPointType, completion: @escaping NetworkRequestCompletion) {
        
        switch endPoint.requestType {
        case .service:
            do {
                let request = try self.buildRequest(endPoint)
                networkSession.loadData(request) { (data, response, error) in
                    guard let rawData = data, error == nil
                        else {
                            completion(nil, nil, NetworkRequestErrors.invalidNetworkRequest)
                            return
                    }
                    completion(rawData, response, error)
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Building request
    private func buildRequest(_ endPoint: EndPointType) throws -> URLRequest {
        
        guard let urlToLoad = URL(string: endPoint.baseURL)
            else {
                throw NetworkRequestErrors.invalidUrl
        }
        
        // prepare URLRequest
        var request = URLRequest(url: urlToLoad.appendingPathComponent(endPoint.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 15.0)
        
        // set http method
        request.httpMethod = endPoint.httpMethod.rawValue
        
        // encoding right type of body
        // not available here in this example
        
        // setting endpoint specific headers
        for (key, value) in endPoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
