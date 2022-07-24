//
//  LearningViewModel.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation

class LearningViewModel: ObservableObject {
    let coreDataHelper = CoreDataHelper.instance
    @Published var learningData: [Learning] = []
    
    init(){
        fetchLearning()
    }
    
    func fetchLearning() {
        let context = coreDataHelper.getBackgroundContext()
        let fetchRequest = LearningEntity.fetchRequest()
        do{
            let learning = try context.fetch(fetchRequest)
            let _ = learning.map { LearningEntity in
                if let title = LearningEntity.title,
                   let goal = LearningEntity.goal,
                   let tasks = LearningEntity.tasks,
                   let createdTime = LearningEntity.createdTime {
                    learningData.append(Learning(title: title, goal: goal, hasCompleted: LearningEntity.hasCompleted, tasks: Array((tasks as? Set<Task>)!), createdTime: createdTime))
                }
            }
        }
        catch{
            print("Error fetching Core Data \(error.localizedDescription)")
        }
    }
    
    func addLearning(title: String) {
        let context = coreDataHelper.getBackgroundContext()
        let learning = LearningEntity(context: context)
        learning.id = UUID()
        learning.title = title
        learning.goal = ""
        learning.hasCompleted = false
        learning.tasks = []
        learning.createdTime = Date()
        coreDataHelper.saveContext(context: context)
        print("ADd Learning success")
    }
    func updateLearning() {
        
    }
    func deleteLearning() {
        
    }
    
}
