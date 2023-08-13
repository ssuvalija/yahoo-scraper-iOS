//
//  APIManager.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/12/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    private let baseURL = "http://localhost:8080/api"
    
    func sendRequest<T: Codable>(path: String, method: String, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let fullURL = URL(string: baseURL + path)!
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
