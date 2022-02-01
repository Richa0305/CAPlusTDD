//
//  RecipeModel.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 23/01/2022.
//

import Foundation

// MARK: - RecipeModelElement
struct RecipeModelElement: Codable {
    var id, name, headline: String?
    var image: String?
    var preparationMinutes: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, headline, image
        case preparationMinutes = "preparation_minutes"
    }
}

typealias RecipeModel = [RecipeModelElement]
