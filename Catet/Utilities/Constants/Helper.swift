//
//  Helper.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 25/07/22.
//

import Foundation

class Helper {
    static func dateToString(date: Date, format: String = "dd/MM/yyyy HH:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    static func stringToDate(dateInString: String, format: String = "dd/MM/yyyy HH:mm a") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateInString) ?? Date()
    }
}
