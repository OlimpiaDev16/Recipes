//
//  NetworkServiceTests.swift
//  RecipesTests
//
//  Created by Olimpia Compean on 2/11/25.
//

import XCTest
@testable import Recipes

final class NetworkServiceTests: XCTestCase {
    var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    func testFetchRecipesWithSuccess() async throws {
        mockService.mockData =  """
         {
            "recipes": [
                {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://example.com/large.jpg",
                "photo_url_small": "https://example.com/small.jpg",
                "source_url": "https://example.com/recipe",
                "uuid": "123e4567-e89b-12d3-a456-426614174000",
                "youtube_url": "https://youtube.com/video"
                }
            ]
        }
        """.data(using: .utf8)
        let result: RecipeCollection = try await self.mockService.fetchData(from: "https://mock-url.com")
        XCTAssertEqual(result.recipes.count, 1)
        XCTAssertEqual(result.recipes.first?.name, "Apam Balik")
    }
    
    func testFetchRecipesWithInvalidData() async throws {
        mockService.mockData = "invalid data".data(using: .utf8)
        
        do {
            let _: RecipeCollection = try await mockService.fetchData(from: "https://mock-url.com")
            XCTFail("Expected error but got a valid result")
        } catch let error {
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testFetchRecipesWithNetworkFailure() async throws {
        mockService.shouldThrowError = true
        
        do {
            let _: RecipeCollection = try await mockService.fetchData(from: "https://mock-url.com")
            XCTFail("Expected NetworkError.requestFail but instead the request succeeded")
        } catch let error {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
