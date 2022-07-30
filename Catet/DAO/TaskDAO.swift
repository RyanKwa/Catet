//
//  TaskDAO.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 30/07/22.
//

import CoreData
import Foundation

//MARK: CRUD TASK
class TaskDAO {
    static let instance = TaskDAO()
    private var learning: LearningEntity?
    private let coreDataHelper: CoreDataHelper
    
    init() {
        coreDataHelper = CoreDataHelper.instance
    }
    
    func currentLearning(learning: LearningEntity){
        self.learning = learning
    }

    func fetchTask() -> [TaskEntity] {
        guard let learning = self.learning else {
            return []
        }
        return learning.wrappedTasks
        
    }
    
    func addTask(task: Task) -> TaskEntity? {
        guard learning != nil else {
            return nil
        }

        let newTask = TaskEntity(context: coreDataHelper.viewContext)
        
        newTask.id = task.id
        newTask.title = task.title
        newTask.hasFinished = false
        newTask.reminder = task.reminder
        newTask.documentation = task.documentation
        newTask.priority = Int16(task.priority ?? 1)
        self.learning?.addToTasks(newTask)
        
        if let _ = newTask.wrappedReminder {
            NotificationManager.instance.scheduleNotification(task: newTask)
        }
        saveData()
        return newTask
    }
    
    func update(task: TaskEntity, with updatedTask: Task){
        guard learning != nil else {
            return
        }
        task.title = updatedTask.title
        task.documentation = updatedTask.documentation
        task.reminder = updatedTask.reminder
        saveData()
        
    }
    
    func updateTaskCompletion(for task: TaskEntity){
        guard learning != nil else {
            return
        }
        task.hasFinished.toggle()
        saveData()
    }
    
    func removeTask(task: TaskEntity){
        guard learning != nil else {
            return
        }
//        self.taskList.remove(at: taskAtIdx)
        self.learning?.removeFromTasks(task)
//        self.learning?.tasks = Set(taskList) as NSSet

        saveData()
    }

    
    private func saveData(){
        if coreDataHelper.viewContext.hasChanges {
            coreDataHelper.saveContext()
        }
    }
    
}
