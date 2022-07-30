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
    private let learningDAO = LearningDAO.instance
    @Published var completedLearning: [LearningEntity] = []
    @Published var onGoingLearning: [LearningEntity] = []
    init(){
        fetchOnGoingLearning()
        fetchcompletedLearning()
    }
    
    
    func fetchOnGoingLearning() {
        onGoingLearning = learningDAO.fetchOnGoingLearning()
    }
    
    
    func fetchcompletedLearning() {
        completedLearning = learningDAO.fetchcompletedLearning()
    }
    
    
    func updateLearningTask(learning: LearningEntity, taskList: [TaskEntity]){
        learningDAO.updateLearningTask(learning: learning, taskList: taskList)
        fetchcompletedLearning()
    }
    
    func addLearning(title: String) {
        withAnimation(.easeIn(duration: 1.0)){
            learningDAO.addLearning(title: title)
            fetchOnGoingLearning()
        }
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
    
    func updateLearningGoal(learning: LearningEntity, newGoal: String) {
        learningDAO.updateLearningGoal(learning: learning, newGoal: newGoal)
        fetchOnGoingLearning()
    }
    
    func updateLearningStatus(learning: LearningEntity){
        let completedTasks = learning.wrappedTasks.filter { task in
            task.hasFinished
        }.count
        if completedTasks == 0 {
            return
        }
        if completedTasks != learning.wrappedTasks.count {
            return
        }
        for task in learning.wrappedTasks {
            print("Task: \(task)")
            NotificationManager.instance.removeNotifications(task: task)
        }
//        withAnimation(.easeInOut(duration: 1.0)){
            learningDAO.updateLearningStatus(learning: learning)
            fetchOnGoingLearning()
            fetchcompletedLearning()
//        }
    }
    func renameLearning(learning: LearningEntity, newTitle: String){
        learningDAO.renameLearningTitle(learning: learning, newTitle: newTitle)
        fetchOnGoingLearning()

    }
    func deleteLearning(learning: LearningEntity) {
        learningDAO.deleteLearning(learning: learning)
        fetchOnGoingLearning()
        fetchcompletedLearning()
    }
    func deletaAll(){
        learningDAO.deleteAllData()
        fetchOnGoingLearning()
        fetchcompletedLearning()
    }
}
