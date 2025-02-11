//
//  NetworkService.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

protocol NetworkFetching {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}
final class NetworkService: NetworkFetching {
    
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
}

final class MockNetworkService: NetworkFetching {
    var mockData: Data?
    var shouldThrowError: Bool = false
    
    func fetchData<T>(from urlString: String) async throws -> T where T : Decodable {
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
}
