//
//  TaskDetailView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var taskVM: TaskViewModel
    @State var task: TaskEntity
    @State var taskTitle: String
    @State private var showReminder = false
    @State private var isEditingMode = false
    @State private var documentation = ""
    @State private var textStyle = UIFont.TextStyle.body
    @State private var reminder = Date()
    
    var body: some View {
        VStack{
            Form{
                if isEditingMode{
                    Section{
                        TextField("", text: $taskTitle)
                            .animation(nil, value: UUID())
                        
                    } header: {
                        Text("Task Name")
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
                    Section{
                        TextView(text: $documentation, textStyle: $textStyle, isEditing: $isEditingMode)
                            .frame(height: UIScreen.main.bounds.height)
                    }header: {
                        Text("WRITE YOUR PROBLEMS OR REFERENCES HERE")
                    }
                }
                else{
                    Section{
                        Text("\(task.wrappedTitle)")
                            .animation(nil, value: UUID())
                            .lineLimit(1)
                        
                    } header: {
                        Text("Task Name")
                    }
                    
                    Section{
                        TextView(text: $documentation, textStyle: $textStyle, isEditing: $isEditingMode)
                            .frame(height: UIScreen.main.bounds.height)
                        
                    }header: {
                        Text("WRITE YOUR PROBLEMS OR REFERENCES HERE")
                    }
                }
            }
            .onAppear{
                if let taskReminder = task.wrappedReminder{
                    reminder = taskReminder
                    showReminder = true
                }
                self.documentation = task.wrappedDocumentation
                
            }
            .onDisappear{
                if !showReminder{
                    self.taskVM.update(task: task, with: Task(title: taskTitle, reminder: nil, documentation: documentation, priority: 0))
                }
                else{
                    self.taskVM.update(task: task, with: Task(title: taskTitle, reminder: reminder, documentation: documentation, priority: 0))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                        )
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isEditingMode.toggle()
                        }
                    } label: {
                        isEditingMode ? Text("Done")
                            .bold()
                            .animation(nil, value: UUID())
                            .navigationTitle("Task Detail - Editing")
                        : Text("Edit")
                            .animation(nil, value: UUID())
                            .navigationTitle("Task Detail")
                    }
                    
                }
            }
            .background(Color(UIColor.systemGray5))
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskVM: TaskViewModel(), task: TaskEntity(), taskTitle: "Task1")
    }
}
