//
//  LearningDetailView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct LearningDetailView: View {
    var navigationTitle: String
    @State private var editMode = EditMode.inactive
    @State private var isEditing = false
    @State private var goalDescription = ""
    @State private var taskData = ["Learn", "Implement", "Review"]
    @State private var presentAddSheet = false
    var body: some View {
        
        VStack {
            Form {
                //MARK: MY Goal text field
                Section {
                    TextField("", text: $goalDescription)
                } header: {
                    Text("My Goal")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                        .bold()
                        .textCase(.none)
                        .padding(.leading, -20)
                }
                //MARK: MY Task list
                Section {
                    ForEach(taskData, id: \.self) { taskData in
                        NavigationLink(destination: TaskDetailView(taskName: "Learn CoreData").accentColor(Color(Theme.accentColor.rawValue))) {
                            TaskView()
                        }
                    }
                    //MARK: Rearrange Task 
                    .onMove {source, dest in
                        print("UPdate")
                        print(source)
                        print(dest)
                    }
                    //MARK: Delete Task
                    .onDelete { index in
                        print("Delete")
                        print(index)
                    }
                } header: {
                    HStack{
                        Text("My Task")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .bold()
                            .textCase(.none)
                            .padding(.leading, -20)
                        Spacer()
                        //MARK: Add task button
                        Button {
                            print("Add Task")
                            presentAddSheet.toggle()
                        } label: {
                            Label("Add new Task", systemImage: "plus")
                                .foregroundColor(Color(Theme.accentColor.rawValue))
                                .font(.system(size: 17, weight: .semibold, design: .default))
                                .textCase(.none)
                        }.sheet(isPresented: $presentAddSheet) {
                            AddTaskSheet()
                        }
                    }
                }
            }
            //MARK: Edit Button
            .toolbar{
                EditButton()
            }
            .navigationTitle("\(navigationTitle)")
        }
        .background(Color(uiColor: UIColor.systemGray5))
        .onAppear{
            UIAppearanceHelper.setupNavigationTitle(withColor: .white)
        }
        .accentColor(Color(Theme.accentColor.rawValue))
        
    }
}

struct LearningDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LearningDetailView(navigationTitle: "CoreData").navigationTitle("CoreData")
        }
    }
}
