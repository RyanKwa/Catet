//
//  CatAPIFetcher.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import Foundation

class CatAPIManager {
    static let instance = CatAPIManager()
    
    func fetchCat(breed: String, onCompletion: @escaping ([CatAPI]) -> ()){
        let url = URL(string: "\(CatAPIEndpoints.BREED_ENDPOINT)=\(breed)")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            //MARK: add http header for API auth
            request.addValue(CatAPIEndpoints.API_KEY, forHTTPHeaderField: "x-api-key")
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in

                guard let data = data else {
                    print("Data from URL is nil")
                    return
                }
                
                guard let catAPI = try? JSONDecoder().decode([CatAPI].self, from: data) else{
                    print("Failed to convert cat API data ")
                    return
                }
                onCompletion(catAPI)
            }
            task.resume()

        }
    }
}
