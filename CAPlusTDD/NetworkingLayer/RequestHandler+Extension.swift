//
//  RequestHandler+Extension.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation

// MARK: Request Handler Supporting methods

extension RequestHandler {
    
    /// Set default header for request
    /// - Parameter request: Inout URLRequest param to set default header
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(Constants.APIHeaders.contentTypeValue, forHTTPHeaderField: Constants.APIHeaders.kContentType)
    }
}


