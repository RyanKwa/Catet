//
//  Task.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation

struct Task: Identifiable, Hashable{
    var id: UUID?
    var title: String?
    var hasFinished: Bool?
    var reminder: Date?
    var documentation: String?
    var priority: Int?
    init(){
        
    }
    init(id: UUID = UUID(), title: String, hasFinished: Bool = false, reminder: Date?, documentation: String = "", priority: Int) {
        self.id = id
        self.title = title
        self.hasFinished = hasFinished
        self.reminder = reminder
        self.documentation = documentation
        self.priority = priority
    }
}
