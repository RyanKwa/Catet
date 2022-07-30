//
//  LearningDAO.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 28/07/22.
//
import CoreData
import Foundation
// CRUD learning
class LearningDAO {
    static let instance = LearningDAO()
    let coreDataHelper: CoreDataHelper
    init() {
        coreDataHelper = CoreDataHelper.instance
    }
    
    func fetchOnGoingLearning() -> [LearningEntity] {
        let request = NSFetchRequest<LearningEntity>(entityName: "LearningEntity")
        let sort = NSSortDescriptor(key: "createdTime", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            let onGoingLearning = try coreDataHelper.viewContext.fetch(request).filter({ learning in
                !learning.hasCompleted
            })
            return onGoingLearning
        }
        catch{
            print("Error fetching Core Data \(error.localizedDescription)")
        }
        return []
    }
    
    func fetchcompletedLearning() -> [LearningEntity] {
        let request = NSFetchRequest<LearningEntity>(entityName: "LearningEntity")
        let sort = NSSortDescriptor(key: "createdTime", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            let completedLearning = try coreDataHelper.viewContext.fetch(request).filter({ learning in
                learning.hasCompleted
            })
            return completedLearning
        }
        catch{
            print("Error fetching Core Data \(error.localizedDescription)")
        }
        return []
    }
    
    func addLearning(title: String){
        let context = coreDataHelper.viewContext
        let learning = LearningEntity(context: context!)
        learning.id = UUID()
        learning.title = title
        learning.goal = ""
        learning.hasCompleted = false
        learning.tasks = []
        learning.createdTime = Date()
        self.saveData()
    }
    
    func updateLearningGoal(learning: LearningEntity, newGoal: String) {
        learning.goal = newGoal
        saveData()
    }
    
    func updateLearningStatus(learning: LearningEntity){
        learning.hasCompleted = true
        saveData()

    }

    
    func updateLearningTask(learning: LearningEntity, taskList: [TaskEntity]){
        learning.tasks = Set(taskList) as NSSet
        saveData()
    }
    
    func renameLearningTitle(learning: LearningEntity, newTitle: String){
        learning.title = newTitle
        saveData()

    }
    
    func deleteLearning(learning: LearningEntity) {
        for task in learning.wrappedTasks {
            NotificationManager.instance.removeNotifications(task: task)
        }
        
        self.coreDataHelper.viewContext.delete(learning)
        self.saveData()
    }

    private func saveData(){
        if coreDataHelper.viewContext.hasChanges {
            coreDataHelper.saveContext()
        }
    }
    
    func deleteAllData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LearningEntity")
        let batchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try coreDataHelper.getBackgroundContext().execute(batchRequest)
            saveData()
        }
        catch{
            fatalError("Cannot delete data")
        }
    }

    

}
