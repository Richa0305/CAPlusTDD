//
//  RecipeViewModelTest.swift
//  CAPlusTDDTests
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
@testable import CAPlusTDD
import XCTest

class RecipeViewModelTest: XCTestCase {
    func test_getAPIData_forSuccessResponse() {
        let recipeViewModel = MockRecipeViewModel(shouldReturnError: false)
        recipeViewModel.shouldReturnResponse = true
        recipeViewModel.getAPIData { response, error in
            XCTAssertEqual(response?.count, 1)
            XCTAssertEqual(response?.first?.id, "533143aaff604d567f8b4571")
            XCTAssertEqual(response?.first?.name, "Crispy Fish Goujons")
            XCTAssertEqual(response?.first?.headline, "with Sweet Potato Wedges and Minted Snap Peas")
            XCTAssertEqual(response?.first?.image, "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg")
            XCTAssertEqual(response?.first?.preparationMinutes, 35)
        }
        XCTAssertEqual(recipeViewModel.getAPIDataMethodCalled, true)
        
    }
    
    func test_getAPIData_forFailureResponse() {
        let recipeViewModel = MockRecipeViewModel(shouldReturnError: true)
        recipeViewModel.shouldReturnResponse = true
        recipeViewModel.getAPIData { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.message, NetworkErrorType.failed)
        }
        XCTAssertEqual(recipeViewModel.getAPIDataMethodCalled, true)
        
    }
}
