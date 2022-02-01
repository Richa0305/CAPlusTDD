//
//  NetworkError.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
enum NetworkErrorType:String {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

struct NetworkError: Error {
    let message: NetworkErrorType
}
