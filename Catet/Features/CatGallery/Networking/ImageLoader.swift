//
//  ImageLoader.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import Foundation
import UIKit
class ImageLoader: ObservableObject {
    let url: String?
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoadingImage: Bool = false
    
    init(url: String){
        self.url = url
        fetchCatImage()
    }
    
    func fetchCatImage() {
        guard let url = url, let fetchURL = URL(string: url) else {
            errorMessage = "URL not found"
            return
        }
        isLoadingImage = true
        errorMessage = nil
        
        //MARK: Caching
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        let task = URLSession.shared.dataTask(with: fetchURL) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoadingImage = false
                if error != nil {
                    self?.errorMessage = "Cannot fetch current URL"
                }
                else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                }
                
            }
        }
        
        task.resume()
        
    }
}
