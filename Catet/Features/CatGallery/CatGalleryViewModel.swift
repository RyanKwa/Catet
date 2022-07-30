//
//  CatGalleryViewModel.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import Foundation
import CoreData


//Rapository pattern
class CatGalleryViewModel: ObservableObject {
    let catGalleryDAO: CatGalleryDAO
    let catAPIManager: CatAPIManager
    private var catBreeds = ["abys", "asho", "beng", "sibe", "ragd", "munc", "bsho" ,"sfol", "tvan", "norw"]
    @Published var catGalleryData: [CatGalleryEntity] = []
    @Published var catDataFromAPI = [CatAPI]()
    
    init(){
        catGalleryDAO = CatGalleryDAO.instance
        catAPIManager = CatAPIManager.instance
        fetchCatGallery()
    }
    func fetchCatGallery() {
        catGalleryData = catGalleryDAO.fetchCatGallery()
    }
    
    func fetchCatFromAPI(){
        let getCatData = { (cat: [CatAPI]) in
            DispatchQueue.main.async {
                self.catDataFromAPI = cat
            }
        }
        catAPIManager.fetchCat(breed: catBreeds.randomElement()!,onCompletion: getCatData)
    }
    func addCatGallery(catGallery: CatGallery){
        catGalleryDAO.addCatGallery(catGallery: catGallery)
        fetchCatGallery()
    }
    func removeCatGallery(){
        catGalleryDAO.removeCatGallery()
        fetchCatGallery()
    }
}
