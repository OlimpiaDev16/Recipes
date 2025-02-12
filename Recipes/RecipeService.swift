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
                let largeImage = try await networkService.fetchImage(from: URL(string: recipe.photoURL) ?? URL(fileURLWithPath: ""))
                
                let recipeWithImage = RecipeWithImage(
                    recipe: recipe,
                    image: largeImage
                )
                
                recipesWithImages.append(recipeWithImage)
            } catch {
                print("Failed to fetch for recipe \(recipe.name)")
                let recipeWithImage = RecipeWithImage(
                    recipe: recipe,
                    image: nil
                )
                
                recipesWithImages.append(recipeWithImage)
            }
        }
        return recipesWithImages
    }
}

struct RecipeWithImage: Identifiable, Hashable {
    let recipe: RecipeCollection.Recipe
    let image: UIImage?
    let ID: UUID = UUID()
    var id: String {
        recipe.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recipe.id)
    }
    
    static func == (lhs: RecipeWithImage, rhs: RecipeWithImage) -> Bool {
        return lhs.recipe.id == rhs.recipe.id
    }
}
