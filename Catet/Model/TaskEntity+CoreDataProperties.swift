//
//  TaskEntity+CoreDataProperties.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var documentation: String?
    @NSManaged public var hasFinished: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var priority: Int16
    @NSManaged public var reminder: Date?
    @NSManaged public var title: String?
    @NSManaged public var learning: LearningEntity?
    
    public var wrappedTitle: String {
        return title ?? ""
    }
    public var wrappedId: UUID {
        return id ?? UUID()
    }

    public var wrappedReminder: Date? {
        return reminder ?? nil
    }

    public var wrappedDocumentation: String {
        return documentation ?? ""
    }
}

extension TaskEntity : Identifiable {

}
