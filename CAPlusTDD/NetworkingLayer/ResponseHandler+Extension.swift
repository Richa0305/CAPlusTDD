//
//  ResponseHandler+Extension.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation

// MARK: Response Handler - parse default method
extension ResponseHandler {
    /// Generi  parser to decode JSON
    /// - Returns: Type of value to decode from Json
    func defaultParseResponse<T: Codable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            return body
        } catch  {
            
            throw NetworkError(message: NetworkErrorType.unableToDecode)
        }
        
    }
}
