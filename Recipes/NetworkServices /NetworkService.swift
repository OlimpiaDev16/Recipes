//
//  NetworkService.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

protocol NetworkFetching {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}

class NetworkService: NetworkFetching {
    private var imageCache = NSCache<NSURL, UIImage>()
    
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidURL
        }
        
        imageCache.setObject(image, forKey: url as NSURL)
        
        return image
    }
}

class MockNetworkService: NetworkService {
    var mockData: Data?
    var shouldThrowError: Bool = false
    var mockImage: UIImage?
    
    override func fetchData<T>(from urlString: String) async throws -> T where T : Decodable {
        if shouldThrowError {
            throw NetworkError.requestFailed
        }
        guard let data = mockData else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    override func fetchImage(from url: URL) async throws -> UIImage {
        if shouldThrowError {
            throw NetworkError.requestFailed
        }
        
        guard let image = mockImage else {
            throw URLError(.cannotDecodeContentData)
        }
        return image
    }
}
