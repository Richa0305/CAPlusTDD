//
//  APIEndpoint.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
//https://raw.githubusercontent.com/Richa0305/images/main/mock.json
#if DEBUG
    // set developemnt environment baseURL
    let baseURL = "https://hf-mobile-app.s3-eu-west-1.amazonaws.com"
#else
    // set production environment baseURL
    let baseURL = "https://hf-mobile-app.s3-eu-west-1.amazonaws.com"
#endif

struct APIPath {
    static var recipes: String { return "https://raw.githubusercontent.com/Richa0305/images/main/mock.json"}
}
