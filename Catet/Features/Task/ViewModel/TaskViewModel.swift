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
    private var taskDAO: TaskDAO
    private var learning: LearningEntity?
    @Published var taskList: [TaskEntity] = []
    @Published var goalCompleted = false
    
    
    @State var taskTtitle: String = ""
    init(){
        taskDAO = TaskDAO()
    }
    func currentLearning(learning: LearningEntity){
        self.learning = learning
        taskDAO.currentLearning(learning: learning)
    }
    func fetchTasks(){
        taskList = taskDAO.fetchTask()
    }
    
    //add task di vm pakai property diatas
    func addTask(task: Task){
        let newTask = taskDAO.addTask(task: task)
        if let newTask = newTask, newTask.wrappedReminder != nil {
            NotificationManager.instance.scheduleNotification(task: newTask)
        }
        fetchTasks()
        resetPriority()
    }
    func update(task: TaskEntity, with updatedTask: Task){
        guard learning != nil else {
            return
        }
        taskDAO.update(task: task, with: updatedTask)
        fetchTasks()
        if let _ = task.wrappedReminder {
            NotificationManager.instance.scheduleNotification(task: task)
        }
    }
    
    func updateTaskCompletion(for task: TaskEntity){
        guard learning != nil else {
            return
        }
        taskDAO.updateTaskCompletion(for: task)
        fetchTasks()
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
        if let _ = task.wrappedReminder {
            NotificationManager.instance.removeNotifications(task: task)
        }
        withAnimation(.easeInOut(duration: 1.0)){
            taskDAO.removeTask(task: task)
            fetchTasks()
        }
        resetPriority()
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
