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
        let largePhotoURL: URL
        let smallPhotoURL: URL
        let sourceURL: URL
        let id: UUID
        let youtubeURL: URL
        
        enum CodingKeys: String, CodingKey {
            case cuisine
            case name
            case largePhotoURL = "photo_url_large"
            case smallPhotoURL = "photo_url_small"
            case sourceURL = "source_url"
            case id = "uuid"
            case youtubeURL = "youtube_url"
        }
    }
}

