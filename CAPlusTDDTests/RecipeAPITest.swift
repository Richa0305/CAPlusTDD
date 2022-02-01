//
//  RecipeAPITest.swift
//  CAPlusTDDTests
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
import XCTest
@testable import CAPlusTDD

class RecipeAPITest: XCTestCase  {
    func test_makeRequest() {
        let api = RecipeAPI()
        let request = api.makeRequest(urlString: APIPath.recipes, withParams: [:])
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.absoluteString, APIPath.recipes)
    }
    
    
    func test_parseResponse() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "recipeAPIResponse", withExtension: "json") else {
            return
        }
        let data = try Data(contentsOf: url)
        let api = RecipeAPI()
        let response = try api.parseResponse(data: data)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response.count, 2)
        XCTAssertEqual(response.first?.id, "533143aaff604d567f8b4571")
        XCTAssertEqual(response.first?.name, "Crispy Fish Goujons")
        XCTAssertEqual(response.first?.headline, "with Sweet Potato Wedges and Minted Snap Peas")
        XCTAssertEqual(response.first?.image, "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")
        XCTAssertEqual(response.first?.preparationMinutes, 35)
        
    }
}
