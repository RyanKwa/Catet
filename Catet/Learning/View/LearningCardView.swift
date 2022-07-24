//
//  LearningCardView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

struct LearningCardView: View {
    var learningTitle: String
    var learningGoal: String
    var finishedTask: Int = 4
    var totalTask: Int = 5
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(learningTitle)")
                    .bold()
                    .font(.headline)
                    .padding(.bottom, 1)
                Text("\(learningGoal)")
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.subheadline)
            }.padding(.vertical)
            Spacer()
            if calculateTaskProgress() < 100 {
                ZStack{
                    Circle()
                        .frame(width: 60, alignment: .center)
                        .foregroundColor(.white)
                    Circle()
                        .strokeBorder(Color(Theme.darkgreen.rawValue).opacity(0.25), lineWidth: 7, antialiased: true)
                        .overlay{
                            Text("\(calculateTaskProgress())%")
                                .font(.subheadline)
                        }
                        .overlay{
                            ProgressArc(finishedTask: self.finishedTask, totalTask: self.totalTask)
                                .rotation(Angle(degrees: -90))
                                .stroke(Color(Theme.darkgreen.rawValue), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                
                        }
                        .frame(width: 60, alignment: .center)
                }
            }
            else if calculateTaskProgress() == 100 {
                Image(systemName: "checkmark")
                    .imageScale(.large)
                    .font(.system(size: 35))
                    .foregroundColor(Color(Theme.accentColor.rawValue))
//                    .background(Color.red)
            }
        }
    }

    func calculateTaskProgress() -> Int {
        return Int(Double(finishedTask)/Double(totalTask) * 100)
    }
}

struct LearningCardView_Previews: PreviewProvider {
    static var previews: some View {
        LearningCardView(learningTitle: "CoreData", learningGoal: "I will build a core data app with CRUD functionality", finishedTask: 5, totalTask: 5)
    }
}
