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
    var hasFinished: String?
    var reminder: Date?
    var documentation: String?
    var priority: Int?
    
}
