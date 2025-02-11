//
//  RecipeViewModelTests.swift
//  RecipesTests
//
//  Created by Olimpia Compean on 2/11/25.
//

import XCTest
@testable import Recipes

final class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!
    var mockService: MockNetworkService!
    var recipeService: RecipeService!
    
    @MainActor override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        recipeService = RecipeService(networkService: mockService)
        viewModel = RecipeViewModel(recipeService: recipeService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        recipeService = nil
        super.tearDown()
    }
    
    func testFetchRecipesWithSuccess() async throws {
        let json = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://example.com/large.jpg",
                "photo_url_small": "https://example.com/small.jpg",
                "source_url": "https://example.com/source",
                "uuid": "123e4567-e89b-12d3-a456-426614174000",
                "youtube_url": "https://youtube.com/example"
            }
        ]
    }
    """.data(using: .utf8)
        
        let testImage = UIImage(systemName: "photo")!
        
        mockService.mockData = json
        mockService.mockImage = testImage
        
        await viewModel.fetchRecipes()
        
        await MainActor.run {
            XCTAssertFalse(viewModel.recipesWithImages.isEmpty, "Recipes should not be empty after a successful fetch")
            XCTAssertEqual(viewModel.recipesWithImages.first?.recipe.name, "Apam Balik")
            XCTAssertNotNil(viewModel.recipesWithImages.first?.largeImage, "large image should be loaded successfully")
            XCTAssertNotNil(viewModel.recipesWithImages.first?.smallImage, "small image should be loaded successfully")
        }
    }
    
    func testFetchRecipes_Failure() async {
        mockService.shouldThrowError = true
        
        await viewModel.fetchRecipes()
        
        await MainActor.run {
            XCTAssertTrue(viewModel.recipesWithImages.isEmpty, "Recipes should be empty after a failed fetch")
            XCTAssertNotNil(viewModel.errorMessage, "Error message should be set after failure")
        }
    }
    
}
