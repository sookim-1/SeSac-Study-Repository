//
//  NetworkManager.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.punkapi.com/v2/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getBeers(for name: String, page: Int, completed: @escaping (Result<[Beer], ProjectError>) -> Void) {
        let endpoint = baseURL + "beers?page=\(page)&per_page=25"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidBeername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let beers = try decoder.decode([Beer].self, from: data)
                completed(.success(beers))
            } catch {
                completed(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
}
