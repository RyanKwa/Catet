//
//  TaskDetailView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct TaskDetailView: View {
    @State var taskName: String
    @State private var showReminder = false
    @State private var isEditingMode = false
    @State private var taskDocumentation = ""
    @State private var textStyle = UIFont.TextStyle.body
    var body: some View {
        VStack{
            Form{
                if isEditingMode{
                    Section{
                        TextField("", text: $taskName)
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
                            DatePicker("", selection: .constant(Date()))
                        }
                    }
                    Section{
//                        TextEditor(text: $taskDocumentation).frame(height: UIScreen.main.bounds.height)
                        TextView(text: $taskDocumentation, textStyle: $textStyle, isEditing: $isEditingMode)
                            .frame(height: UIScreen.main.bounds.height)
                    }header: {
                        Text("WRITE YOUR PROBLEMS OR REFERENCES HERE")
                    }
                }
                else{
                    Section{
                        Text("\(taskName)")
                            .animation(nil, value: UUID())
                            .lineLimit(1)
                        
                    } header: {
                        Text("Task Name")
                    }

                    Section{
//                        Text("\(taskDocumentation)")
                        TextView(text: $taskDocumentation, textStyle: $textStyle, isEditing: $isEditingMode)
                            .frame(height: UIScreen.main.bounds.height)

                    }header: {
                        Text("WRITE YOUR PROBLEMS OR REFERENCES HERE")
                    }
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
        TaskDetailView(taskName: "Learn CoreData")
    }
}
