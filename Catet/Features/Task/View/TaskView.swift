//
//  TaskView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct TaskView: View {
    
    @State var task: TaskEntity
    @ObservedObject var taskVM: TaskViewModel
    
    var body: some View {
        HStack {
            ZStack{
                Button {
                    print("Checklist")
                    taskVM.updateTaskCompletion(for: task)
                } label: {
                    if task.hasFinished {
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(Theme.accentColor.rawValue))
                    }
                    else{
                        Image(systemName: "square")
                            .font(.system(size: 24))
                            .foregroundColor(Color(Theme.accentColor.rawValue))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 5)
            }
            VStack(alignment: .leading){
                Spacer()
                Text(task.wrappedTitle)
                Spacer()
                if let taskReminder = task.wrappedReminder {
                    Text(Helper.dateToString(date: taskReminder))
                }
                else{
                    Text("")
                }
                Spacer()
            }
            Spacer()
            
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: TaskEntity(), taskVM: TaskViewModel())
            .previewLayout(.fixed(width: UIScreen.main.bounds.size.width, height: 54))
    }
}
