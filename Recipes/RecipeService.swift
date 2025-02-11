//
//  RecipeService.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import UIKit
import Foundation

struct RecipeService {
    let networkService: NetworkService
    let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func fetchRecipes() async throws -> RecipeCollection {
        return try await networkService.fetchData(from: baseURL)
    }
    
    func fetchRecipesAndImages() async throws -> [RecipeWithImage] {
        let recipeCollection: RecipeCollection = try await fetchRecipes()
        
        var recipesWithImages: [RecipeWithImage] = []
        
        for recipe in recipeCollection.recipes {
            do {
                let largeImage = try await networkService.fetchImage(from: recipe.largePhotoURL)
                let smallImage = try await networkService.fetchImage(from: recipe.smallPhotoURL)
                
                let recipeWithImage = RecipeWithImage(
                    recipe: recipe,
                    largeImage: largeImage,
                    smallImage: smallImage
                )
                
                recipesWithImages.append(recipeWithImage)
            } catch {
                print("Failed to fetch for recipe \(recipe.name)")
                let recipeWithImage = RecipeWithImage(
                    recipe: recipe,
                    largeImage: nil,
                    smallImage: nil
                )
                
                recipesWithImages.append(recipeWithImage)
            }
        }
        return recipesWithImages
    }
}

struct RecipeWithImage {
    let recipe: RecipeCollection.Recipe
    let largeImage: UIImage?
    let smallImage: UIImage?
}
