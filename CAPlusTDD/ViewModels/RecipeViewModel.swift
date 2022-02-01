//
//  RecipeViewModel.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 23/01/2022.
//

import Foundation

protocol RecipeViewModelProtocol {
    func getAPIData(completion: @escaping (RecipeModel?, NetworkError?) -> ())
}

struct RecipeViewModel : RecipeViewModelProtocol {
    
    let recipeAPI: RecipeAPI
    
    init(recipeAPI: RecipeAPI){
        self.recipeAPI = recipeAPI
    }
    
    func getAPIData(completion: @escaping (RecipeModel?, NetworkError?) -> ()) {
        
        let apiLoader = APILoader(apiHandler: self.recipeAPI)
        apiLoader.loadAPIRequest(urlString: APIPath.recipes, requestData: [:]) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}

