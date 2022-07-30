//
//  CatGallery.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 24/07/22.
//

import Foundation

struct CatGallery: Identifiable {
    var id: UUID?
    var url: String?
    var dateFinished: Date?
    var goalCompleted: String?
    init(id: UUID? = UUID(), url: String? = nil, dateFinished: Date? = Date(), goalCompleted: String? = "") {
        self.id = id
        self.url = url
        self.dateFinished = dateFinished
        self.goalCompleted = goalCompleted
    }
}
