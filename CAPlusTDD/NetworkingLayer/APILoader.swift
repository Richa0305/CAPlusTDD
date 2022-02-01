//
//  APILoader.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation

struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    /// Load API request using URLSession
    /// - Parameters:
    ///   - urlString: URL String for which API needs to be called
    ///   - requestData: Request data params
    ///   - completionHandler: Parsed Response of Associated Type
    func loadAPIRequest(urlString: String, requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, NetworkError?) -> ()) {
        if let urlRequest = apiHandler.makeRequest(urlString: urlString, withParams: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, handleNetworkResponse(httpResponse))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, NetworkError(message:NetworkErrorType.noData))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData)
                        completionHandler(parsedResponse, nil)
                    } catch {
                        completionHandler(nil, NetworkError(message: NetworkErrorType.unableToDecode))
                    }
                    
                }
            }.resume()
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkError {
        switch response.statusCode {
        case 401...500: return NetworkError(message: NetworkErrorType.authenticationError)
        case 501...599: return NetworkError(message: NetworkErrorType.badRequest)
        case 600: return NetworkError(message: NetworkErrorType.outdated)
        default: return NetworkError(message: NetworkErrorType.failed)
        }
    }
}
