//
//  AddTaskSheet.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct AddTaskSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle = ""
    @State private var showReminder = false
    var body: some View {
            NavigationView{
                Form{
                    Section{
                        TextField("", text: $taskTitle)
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
                            DatePicker("", selection: .constant(Date()))
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
        AddTaskSheet()
    }
}
