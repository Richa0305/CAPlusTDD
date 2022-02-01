//
//  APILoaderTest.swift
//  CAPlusTDDTests
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
@testable import CAPlusTDD
import XCTest

class APILoaderTest: XCTestCase {
    func test_loadAPIRequest_forSuccessResponse() throws {
        let sut = try setupAPILoaderForSuccessResponse()
        
        let expectation = expectation(description: "SuccessExpection")
        sut.loadAPIRequest(urlString: APIPath.recipes, requestData: [:]) { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            XCTAssertEqual(response?.count, 2)
            XCTAssertEqual(response?.first?.id, "533143aaff604d567f8b4571")
            XCTAssertEqual(response?.first?.name, "Crispy Fish Goujons")
            XCTAssertEqual(response?.first?.headline, "with Sweet Potato Wedges and Minted Snap Peas")
            XCTAssertEqual(response?.first?.image, "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")
            XCTAssertEqual(response?.first?.preparationMinutes, 35)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func test_loadAPIRequest_forFailure() throws {
        let sut = try setupAPILoaderForFailure()
        let expectation = expectation(description: "FailureExpection")
        sut.loadAPIRequest(urlString: APIPath.recipes, requestData: [:]) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    // MARK : Create SUT
    
    func setupAPILoaderForSuccessResponse() throws -> APILoader<RecipeAPI> {
        let apiLoader = self.setupAPILoader()
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "recipeAPIResponse", withExtension: "json") else {
            throw NetworkError(message: NetworkErrorType.badRequest)
        }
        let data = try Data(contentsOf: url)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                    url.absoluteString == APIPath.recipes,
                    let response = HTTPURLResponse(url: url,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil) else {
                throw NetworkError(message: NetworkErrorType.badRequest)
            }
            
            return (response, data)
        }
        return apiLoader
    }
    
    
    func setupAPILoaderForFailure() throws -> APILoader<RecipeAPI> {
        let apiLoader = self.setupAPILoader()
        
      
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                    url.absoluteString == APIPath.recipes,
                    let response = HTTPURLResponse(url: url,
                                                   statusCode: 400,
                                                   httpVersion: nil,
                                                   headerFields: nil) else {
                throw NetworkError(message: NetworkErrorType.badRequest)
            }
            
            return (response, nil)
        }
        return apiLoader
    }
    

    
    func setupAPILoader() -> APILoader<RecipeAPI> {
        let recipeAPI = RecipeAPI()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        let apiLoader = APILoader(apiHandler: recipeAPI, urlSession: urlSession)
        return apiLoader
    }
}



