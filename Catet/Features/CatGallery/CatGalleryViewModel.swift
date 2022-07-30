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
    let coreDataHelper: CoreDataHelper
    let catAPIManager: CatAPIManager
    private var catBreeds = ["abys", "asho", "beng", "sibe", "ragd", "munc", "bsho" ,"sfol", "tvan", "norw"]
    @Published var catGalleryData: [CatGalleryEntity] = []
    @Published var catDataFromAPI = [CatAPI]()
    init(){
        coreDataHelper = CoreDataHelper.instance
        catAPIManager = CatAPIManager.instance
        fetchCatGallery()
        for datum in catGalleryData {
            
            print("Debug cat: \(datum.wrappedGoalCompleted)")
            print("Debug cat: \(datum.wrappedDateFinished)")
            print("Debug cat: \(datum.wrappedURL)")
        }
    }
    func fetchCatGallery() {
        let request = NSFetchRequest<CatGalleryEntity>(entityName: "CatGalleryEntity")
        let sort = NSSortDescriptor(key: "dateFinished", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            catGalleryData = try coreDataHelper.viewContext.fetch(request)
        }
        catch {
            print("Error fetching data \(error.localizedDescription)")
        }
    }
    
    func fetchCatFromAPI(){
        let getCatData = { (cat: [CatAPI]) in
            DispatchQueue.main.async {
                self.catDataFromAPI = cat
                
                print("Debug API ARRAY COK \(self.catDataFromAPI)")
            }
        }

        catAPIManager.fetchCat(breed: catBreeds.randomElement()!,onCompletion: getCatData)
    }
    func addCatGallery(catGallery: CatGallery){
        let context = coreDataHelper.viewContext
        let newCatGallery = CatGalleryEntity(context: context!)
        newCatGallery.id = catGallery.id
        newCatGallery.dateFinished = catGallery.dateFinished
        newCatGallery.goalCompleted = catGallery.goalCompleted
        newCatGallery.url = catGallery.url

        coreDataHelper.saveContext()
        fetchCatGallery()


        print("ADd Learning success")
    }
    func removeCatGallery(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CatGalleryEntity")
        let batchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        print("ERROr disni")
        do{
            try coreDataHelper.getBackgroundContext().execute(batchRequest)
            coreDataHelper.saveContext()
        }
        catch{
            fatalError("Cannot delete data")
        }
    }
}
