//
//  CatGalleryEntity+CoreDataProperties.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//
//

import Foundation
import CoreData


extension CatGalleryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatGalleryEntity> {
        return NSFetchRequest<CatGalleryEntity>(entityName: "CatGalleryEntity")
    }

    @NSManaged public var dateFinished: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var url: String?
    @NSManaged public var goalCompleted: String?
    
    public var wrappedDateFinished: Date {
         return dateFinished ?? Date()
     }
     public var wrappedId: UUID {
         return id ?? UUID()
     }
     
     public var wrappedURL: String {
         return url ?? ""
     }
     
     public var wrappedGoalCompleted: String {
         return goalCompleted ?? ""
     }
}

extension CatGalleryEntity : Identifiable {

}
