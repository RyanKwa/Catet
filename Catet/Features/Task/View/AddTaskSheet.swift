//
//  AddTaskSheet.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct AddTaskSheet: View {
    @ObservedObject var taskVM: TaskViewModel
    @EnvironmentObject var learningVM: LearningViewModel
    @State var learning: LearningEntity
    @Environment(\.dismiss) var dismiss
    
    @State private var taskTitle = ""
    @State private var showReminder = false
    @State private var reminder = Date()
    var body: some View {
        
            NavigationView{
                Form{
                    Section{
                        TextField("", text: $taskTitle).foregroundColor(.black)
                    } header: {
                        Text("Set your task")
                    }
                    Section{
                        Toggle(isOn: $showReminder.animation()) {
                            Text("Reminder")
                                .foregroundColor(.black)
                                .textCase(.none)
                                .font(.system(size: 17))
                        }.tint(Color(Theme.accentColor.rawValue))
                        if showReminder {
                            DatePicker("", selection: $reminder)
                        }
                    }
                }
                .navigationBarTitle("Add Task", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Cancel Button")
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                                .textCase(.none)
                                .font(.system(size: 17))
                                
                        }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Save Button")
                            //MARK: Ternary
                            if showReminder{
                                taskVM.addTask(task: Task(title: taskTitle, reminder: reminder, priority: taskVM.taskList.count+1))
//                                learningVM.updateLearningTask(learning: learning, taskList: taskVM.taskList)

                            }
                            else{
                                taskVM.addTask(task: Task(title: taskTitle, reminder: nil, priority: taskVM.taskList.count+1))
//                                learningVM.updateLearningTask(learning: learning, taskList: taskVM.taskList)

                            }
                            dismiss()
                        } label: {
                            Text("Save")
                                .foregroundColor(Color(Theme.accentColor.rawValue))
                                .textCase(.none)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }

                    }
                }

                .background(Color(uiColor: UIColor.systemGray5))

            }

    }
}

struct AddTaskSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskSheet(taskVM: TaskViewModel(),learning: LearningEntity()).environmentObject(LearningViewModel())
    }
}
