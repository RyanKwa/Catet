//
//  Learning.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation

struct Learning: Identifiable {
    var id: UUID?
    var title: String?
    var goal: String?
    var hasCompleted: Bool?
    var tasks: [Task]?
    var createdTime: Date?
    
    init(id: UUID = UUID(), title: String, goal: String, hasCompleted: Bool, tasks: [Task], createdTime: Date) {
        self.title = title
        self.goal = goal
        self.hasCompleted = hasCompleted
        self.tasks = tasks
        self.createdTime = createdTime
    }
}
