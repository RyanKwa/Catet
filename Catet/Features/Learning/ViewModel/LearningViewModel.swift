//
//  LearningViewModel.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation
import CoreData
import SwiftUI

class LearningViewModel: ObservableObject {
    let coreDataHelper: CoreDataHelper
    
    @Published var completedLearning: [LearningEntity] = []
    @Published var onGoingLearning: [LearningEntity] = []
    init(){
        coreDataHelper = CoreDataHelper.instance
        fetchOnGoingLearning()
        fetchcompletedLearning()
    }
    
    
    func fetchOnGoingLearning() {
        let request = NSFetchRequest<LearningEntity>(entityName: "LearningEntity")
        let sort = NSSortDescriptor(key: "createdTime", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            onGoingLearning = try coreDataHelper.viewContext.fetch(request).filter({ learning in
                !learning.hasCompleted
            })
        }
        catch{
            print("Error fetching Core Data \(error.localizedDescription)")
        }
    }
    func updateLearningTask(learning: LearningEntity, taskList: [TaskEntity]){
        for learn in onGoingLearning{
            if learn.wrappedId == learning.wrappedId{
                learn.tasks = Set(taskList) as NSSet
            }
        }
        
        saveData()
    }
    func fetchcompletedLearning() {
        let request = NSFetchRequest<LearningEntity>(entityName: "LearningEntity")
        let sort = NSSortDescriptor(key: "createdTime", ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            completedLearning = try coreDataHelper.viewContext.fetch(request).filter({ learning in
                learning.hasCompleted
            })
        }
        catch{
            print("Error fetching Core Data \(error.localizedDescription)")
        }
    }
    
    func addLearning(title: String) {
        let context = coreDataHelper.viewContext
        let learning = LearningEntity(context: context!)
        learning.id = UUID()
        learning.title = title
        learning.goal = ""
        learning.hasCompleted = false
        learning.tasks = []
        learning.createdTime = Date()
        withAnimation(.easeIn(duration: 1.0)){
            self.saveData()
        }

        
        print("ADd Learning success")
        
    }
    func calculateLearningCompletion(tasks: [TaskEntity]) -> Int{
        let totalTask = tasks.count
        if totalTask == 0 {
            return 0
        }
        let finishedTasks = getFinishedTask(tasks: tasks)
        return Int(Double(finishedTasks)/Double(totalTask) * 100)
    }
    
    func getFinishedTask(tasks: [TaskEntity]) -> Int {
        
        let finishedTask = tasks.filter { task in
            task.hasFinished
        }.count
        return finishedTask
    }
    
    func saveData(){
        if coreDataHelper.viewContext.hasChanges {
            coreDataHelper.saveContext()
            fetchOnGoingLearning()
            fetchcompletedLearning()
        }

    }
    func updateLearningGoal(learning: LearningEntity, newGoal: String) {
        
        for ongoing in onGoingLearning{
            if ongoing.wrappedId == learning.wrappedId {
                ongoing.goal = newGoal
            }
        }
        
        saveData()
    }
    
    func updateLearningStatus(learning: LearningEntity){
        var currentLearning: LearningEntity?
        for ongoing in onGoingLearning{
            if ongoing.wrappedId == learning.wrappedId {
                currentLearning = ongoing
                break;
            }
        }
        guard let currentLearning = currentLearning else {
            return
        }
        
        let completedTasks = currentLearning.wrappedTasks.filter { task in
            task.hasFinished
        }.count
        if completedTasks == 0 {
            return
        }
        if completedTasks != currentLearning.wrappedTasks.count {
            return
        }
        for task in currentLearning.wrappedTasks {
            NotificationManager.instance.removeNotifications(task: task)
        }
        currentLearning.hasCompleted = true
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 1.0)){
                self.coreDataHelper.saveContext()
                self.fetchcompletedLearning()
            }
        }

    }
    func renameLearning(learning: LearningEntity){
        for ongoing in onGoingLearning{
            if ongoing.wrappedId == learning.wrappedId {
                ongoing.title = learning.title
                break
            }
        }
        saveData()
    }
    func deleteLearning(learning: LearningEntity) {
        var foundLearning: LearningEntity? = nil
        if learning.hasCompleted {
            for completed in completedLearning{
                if completed.wrappedId == learning.wrappedId {
                    foundLearning = completed
                    break
                }
            }
        }
        else {
            for ongoing in onGoingLearning{
                if ongoing.wrappedId == learning.wrappedId {
                    foundLearning = ongoing
                    break
                }
            }
        }
        guard let currentLearning = foundLearning else {
            return
        }
        for task in currentLearning.wrappedTasks {
            NotificationManager.instance.removeNotifications(task: task)
        }
        
        self.coreDataHelper.viewContext.delete(currentLearning)
        self.saveData()
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
