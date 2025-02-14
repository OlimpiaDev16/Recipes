//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    private let recipeService: RecipeService
    
    @Published var recipesWithImages: [RecipeWithImage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            let recipes = try await recipeService.fetchRecipesAndImages()
            self.recipesWithImages = recipes
        } catch {
            self.errorMessage = String.loadingErrorText + error.localizedDescription
        }
        isLoading = false 
    }
}
