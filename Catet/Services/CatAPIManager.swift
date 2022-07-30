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
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_ids=\(breed)")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            //MARK: add http header for API auth
            request.addValue("2b67ad33-18f8-4076-9262-1e629b1dda75", forHTTPHeaderField: "x-api-key")
            request.httpMethod = "GET"
            print("debug api \(request)")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in

                guard let data = data else {
                    print("Data from URL is nil")
                    return
                }
                
                guard let catAPI = try? JSONDecoder().decode([CatAPI].self, from: data) else{
                    print("Failed to convert cat API data ")
                    return
                }
                print(catAPI)
                onCompletion(catAPI)
            }
            task.resume()

        }
    }
}
