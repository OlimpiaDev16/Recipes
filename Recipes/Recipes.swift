//
//  Recipes.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import Foundation

struct RecipeCollection: Decodable {
    let recipes: [Recipe]
    
    struct Recipe: Decodable, Identifiable {
        let cuisine: String
        let name: String
        let photoURL: String
        let sourceURL: String?
        let id: String
        let youtubeURL: String?
        
        enum CodingKeys: String, CodingKey {
            case cuisine
            case name
            case photoURL = "photo_url_large"
            case sourceURL = "source_url"
            case id = "uuid"
            case youtubeURL = "youtube_url"
        }
    }
}

