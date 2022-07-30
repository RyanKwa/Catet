//
//  LearningEntity+CoreDataProperties.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//
//

import Foundation
import CoreData


extension LearningEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningEntity> {
        return NSFetchRequest<LearningEntity>(entityName: "LearningEntity")
    }

    @NSManaged public var createdTime: Date?
    @NSManaged public var goal: String?
    @NSManaged public var hasCompleted: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var tasks: NSSet?
    
    public var wrappedTitle: String {
         return title ?? ""
     }
     public var wrappedGoal: String {
         return goal ?? ""
     }
     
     public var wrappedId: UUID {
         return id ?? UUID()
     }
     
     public var wrappedCreatedTime: Date {
         return createdTime ?? Date()
     }
     
     public var wrappedTasks: [TaskEntity] {
         let set = tasks as? Set<TaskEntity> ?? []
         
         return set.sorted {
             $0.priority < $1.priority
         }
     }
}

// MARK: Generated accessors for tasks
extension LearningEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension LearningEntity : Identifiable {

}
