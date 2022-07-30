//
//  CatGalleryDAO.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 30/07/22.
//

import CoreData
import Foundation
//CatGallery CRUD
class CatGalleryDAO {
    static let instance = CatGalleryDAO()
    private let coreDataHelper: CoreDataHelper
    init(){
        coreDataHelper = CoreDataHelper.instance
    }
    
    func fetchCatGallery() -> [CatGalleryEntity] {
        let request = NSFetchRequest<CatGalleryEntity>(entityName: "CatGalleryEntity")
        let sort = NSSortDescriptor(key: "dateFinished", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            let catGalleryData = try coreDataHelper.viewContext.fetch(request)
            return catGalleryData
        }
        catch {
            print("Error fetching data \(error.localizedDescription)")
        }
        return []
    }

    func addCatGallery(catGallery: CatGallery){
        let context = coreDataHelper.viewContext
        let newCatGallery = CatGalleryEntity(context: context!)
        newCatGallery.id = catGallery.id
        newCatGallery.dateFinished = catGallery.dateFinished
        newCatGallery.goalCompleted = catGallery.goalCompleted
        newCatGallery.url = catGallery.url

        coreDataHelper.saveContext()
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
