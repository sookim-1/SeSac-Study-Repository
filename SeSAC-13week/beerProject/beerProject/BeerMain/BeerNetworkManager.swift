//
//  BeerNetworkManager.swift
//  beerProject
//
//  Created by sookim on 2021/12/27.
//

import Foundation
import UIKit

final class BeerNetworkManager {
    static let shared = BeerNetworkManager()
    
    private let baseURL = "https://api.punkapi.com/v2/"
    let cache = NSCache<NSString, UIImage>()
    
    func getBeer(completed: @escaping (Result<BeerModel, ProjectError>) -> Void) {
        let endpoint = baseURL + "beers/random"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToComplete))
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
                let beer = try JSONDecoder().decode(BeerModel.self, from: data)
                completed(.success(beer))
            } catch {
                completed(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
}
