//
//  ProgressArc.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import Foundation
import SwiftUI

struct ProgressArc: Shape {
    
    let finishedTask: Int
    let totalTask: Int
    
    private var degreePerProgress: Double {
        360.0 / Double(totalTask)
    }
    
    private var startAngle: Angle {
        Angle(degrees: 0.0)
    }
    
    private var endAngle: Angle {
        Angle(degrees: degreePerProgress * Double(finishedTask) + startAngle.degrees)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 5.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }

}
