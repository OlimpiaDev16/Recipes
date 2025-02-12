//
//  RecipeServiceTests.swift
//  RecipesTests
//
//  Created by Olimpia Compean on 2/11/25.
//

import XCTest
@testable import Recipes

final class RecipeServiceTests: XCTestCase {
    var recipeService: RecipeService!
    var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        recipeService = RecipeService(networkService: mockService)
    }
    
    override func tearDown() {
        recipeService = nil
        mockService = nil
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
     
        mockService.mockData = json
        
        let recipeCollection = try await recipeService.fetchRecipes()
        
        XCTAssertEqual(recipeCollection.recipes.count, 1)
        XCTAssertEqual(recipeCollection.recipes.first?.cuisine, "Malaysian")
    }
    
    func testFetchRecipesWithNetworkFailure() async {
        mockService.shouldThrowError = true
        
        do {
            _ = try await recipeService.fetchRecipes()
            XCTFail("Expected a failure but got a success instead")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testFetchRecipesAndImagesWithSuccess() async throws {
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
        
        let recipesWithImages = try await recipeService.fetchRecipesAndImages()
        
        XCTAssertEqual(recipesWithImages.count, 1)
        XCTAssertEqual(recipesWithImages.first?.recipe.name, "Apam Balik")
        XCTAssertNotNil(recipesWithImages.first?.image)
    }
}

