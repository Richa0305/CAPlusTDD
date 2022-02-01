//
//  MockRecipeViewModel.swift
//  CAPlusTDDTests
//
//  Created by richa.e.srivastava on 24/01/2022.
//

import Foundation
@testable import CAPlusTDD

class MockRecipeViewModel {
    public var getAPIDataMethodCalled = false
    public var shouldReturnError = false
    public var shouldReturnResponse = false
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension MockRecipeViewModel : RecipeViewModelProtocol {
    func getAPIData(completion: @escaping (RecipeModel?, NetworkError?) -> ()) {
        self.getAPIDataMethodCalled = true
        if shouldReturnResponse {
            if shouldReturnError {
                completion(nil,
                           NetworkError(message: NetworkErrorType.failed))
            } else {
                completion([RecipeModelElement(id: "533143aaff604d567f8b4571",
                                               name: "Crispy Fish Goujons",
                                               headline: "with Sweet Potato Wedges and Minted Snap Peas",
                                               image: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg",
                                               preparationMinutes: 35)],
                           nil)
            }
            
        }
        
    }
}
