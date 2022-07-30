//
//  TaskViewModel.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 25/07/22.
//

import Foundation
import SwiftUI
import CoreData
class TaskViewModel: ObservableObject {
    var coreDataHelper: CoreDataHelper
    var learning: LearningEntity?
    @Published var taskList: [TaskEntity] = []
    @Published var goalCompleted = false
    
    
    @State var taskTtitle: String = ""
    init(){
        coreDataHelper = CoreDataHelper.instance
    }
    func currentLearning(learning: LearningEntity){
        self.learning = learning
    }
    func fetchTasks(){
        guard let learning = self.learning else {
            return
        }
        let tasks = learning.wrappedTasks
        taskList = tasks
        //        print("Tasks")
        //        for task in tasks {
        //            print("Priority :\(task.priority)")
        //            print("Title: \(task.wrappedTitle)")
        //            print("reminder: \(task.wrappedReminder)")
        //            print("documentation: \(task.wrappedDocumentation)")
        //            print("Finished \(task.hasFinished)")
        //            print("")
        //        }
    }
    
    //add task di vm pakai property diatas
    func addTask(task: Task){
        guard let learning = learning else {
            return
        }
        print("debug task add: BEfore")
        for taskList in taskList {
            print("debug task add: \(taskList.wrappedTitle)")
            print("")
        }
        let newTask = TaskEntity(context: coreDataHelper.viewContext)
        
        newTask.id = task.id
        newTask.title = task.title
        newTask.hasFinished = false
        newTask.reminder = task.reminder
        newTask.documentation = task.documentation
        newTask.priority = Int16(task.priority ?? taskList.count + 1)
        self.learning?.addToTasks(newTask)
        
//        print("\n Add")
//        print("debug reminder: \(newTask.wrappedReminder)")
        if let _ = newTask.wrappedReminder {
            NotificationManager.instance.scheduleNotification(task: newTask)
        }
        
        save()
        resetPriority()
//        print("debug task add: BEfore")
//        for taskList in self.learning!.wrappedTasks {
//            print("debug task add: \(taskList.wrappedTitle)")
//            print("")
//        }
//        print("ADd Task success")
    }
    func update(task: TaskEntity, with updatedTask: Task){
        guard learning != nil else {
            return
        }
        
//        print("\nUpdate")
        var foundTask: TaskEntity? = nil
        for taskData in taskList{
            if taskData.wrappedId == task.wrappedId {
                foundTask = taskData
//                print("debug reminder Old Reminder: \(taskData.wrappedReminder)")
                break
            }
        }
        guard let currentTask = foundTask else {
            return
        }
        
        currentTask.title = updatedTask.title
        currentTask.documentation = updatedTask.documentation
        currentTask.reminder = updatedTask.reminder
        
//        print("debug reminder New Reminder: \(currentTask.wrappedReminder)")
        
        save()
        
        if let _ = task.reminder {
//            print("debug reminder set reminder")
            NotificationManager.instance.scheduleNotification(task: task)
        }
    }
    
    func save(){
        if coreDataHelper.viewContext.hasChanges{
            coreDataHelper.saveContext()
            fetchTasks()
            
        }
    }
    func updateTaskCompletion(for task: TaskEntity){
        guard learning != nil else {
            return
        }
        for taskData in taskList{
            if taskData.wrappedId == task.wrappedId {
                taskData.hasFinished.toggle()
                print(taskData.hasFinished)
                break
            }
        }
//        print("TASK")
//        for taskList in taskList {
//            print(taskList.wrappedId)
//            print(taskList.wrappedTitle)
//            print(taskList.wrappedReminder)
//            print(taskList.wrappedDocumentation)
//            print(taskList.hasFinished)
//            print("")
//        }
        
        save()
        
        let finishedTask = taskList.filter { task in
            task.hasFinished
        }.count
        if finishedTask == taskList.count {
            goalCompleted = true
        }
    }
    func removeTask(task: TaskEntity) {
        guard learning != nil else {
            return
        }
        
//        print("\n debug delete: Delete")
        var foundTask: TaskEntity? = nil
        var taskAtIdx = -1
        for idx in 0...taskList.count - 1{
            if taskList[idx].wrappedId == task.wrappedId {
                foundTask = taskList[idx]
                taskAtIdx = idx
                break
            }
        }
        guard taskAtIdx != -1 else {
            return
        }
//        print("debug task delete: BEfore")
//        for taskList in taskList {
//            print("debug delete: \(taskList.wrappedTitle)")
//            print("debug delete: \(taskList.priority)")
//            print("")
//        }
        //        learning?.removeFromTasks(task)
        //        self.taskList.remove
        withAnimation(.easeInOut(duration: 1.0)){
            self.taskList.remove(at: taskAtIdx)
            self.learning?.tasks = Set(taskList) as NSSet
            save()
            resetPriority()
        }
        
//        print("debug task delete: After")
//        for taskList in learning!.wrappedTasks {
//            print("debug delete: \(taskList.wrappedTitle)")
//            print("debug delete: \(taskList.priority)")
//            print("")
//        }
        
        if let _ = foundTask!.wrappedReminder {
            NotificationManager.instance.removeNotifications(task: foundTask!)
        }
    }
    
    func reArrangeTask(fromIndex: IndexSet, toIndex: Int){
        taskList.move(fromOffsets: fromIndex, toOffset: toIndex)
        resetPriority()
    }
    func resetPriority(){
        var currentPriority = 1
        for taskList in taskList {
            taskList.priority = Int16(currentPriority)
            currentPriority += 1
        }
    }
}
