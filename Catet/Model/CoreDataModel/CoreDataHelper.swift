//
//  CoreDataHelper.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import CoreData
import Foundation

class CoreDataHelper{
    static let instance = CoreDataHelper()
    let container: NSPersistentContainer!
    let viewContext: NSManagedObjectContext!
    
    init(){
        container = NSPersistentContainer(name: "Catet")
        viewContext = container.viewContext
    }
    
    // Create background context to be used with core data operation
    func getBackgroundContext() -> NSManagedObjectContext {
        if let context = container?.newBackgroundContext() {
            return context
        } else {
            return viewContext
        }
    }

    // Call save context when changes happen in core data
    func saveContext(context: NSManagedObjectContext? = nil){
        guard let context = context else{
            return
        }
        do{
            try context.save()
        }
        catch{
            print("Error Saving CoreData \(error.localizedDescription)")
        }
    }
}
