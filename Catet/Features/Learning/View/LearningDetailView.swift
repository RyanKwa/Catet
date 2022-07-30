//
//  LearningDetailView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct LearningDetailView: View {

    @EnvironmentObject var learningVM: LearningViewModel
    @Environment(\.dismiss) var dismiss

    @State var learning: LearningEntity
    @State private var editMode: EditMode = .inactive
    @State var goalDescription: String
    @State private var presentAddSheet = false
    @State var showDeleteAlert = false

    @StateObject var taskVM = TaskViewModel()
    @State var selectedTask: TaskEntity? = nil
    var learningCompleted: Bool {
        return learning.hasCompleted
    }
    
    var body: some View {
        
        VStack {
            Form {
                    Section {
                        if editMode == .active {
                            TextField(learning.wrappedGoal, text: $goalDescription)
                                .lineLimit(1)
                        }
                        else{
                            Text(goalDescription)
                                .lineLimit(1)
                        }
                    } header: {
                        Text("My Goal")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .bold()
                            .textCase(.none)
                            .padding(.leading, -20)
                    }

                //MARK: MY Goal text field refactor if dalam section
                //MARK: MY Task list

                Section {
                    
                    if taskVM.taskList.count == 0 {
                        EmptyStateView(emptyStateFor: .task)
                    }

                    else if taskVM.taskList.count > 0 {
                        ForEach(taskVM.taskList, id: \.self) { taskData in
                            
                            //MARK: Task Detail
                            NavigationLink(destination: TaskDetailView(taskVM: taskVM,task: taskData, taskTitle: taskData.wrappedTitle).accentColor(Color(Theme.accentColor.rawValue))) {
                                TaskView(task: taskData, taskVM: taskVM).disabled(learningCompleted)
                                    .swipeActions(allowsFullSwipe: false) {
                                        
                                    Button(role: .destructive) {
                                        print("Delete")
                                        showDeleteAlert.toggle()
                                        selectedTask = taskData
                                    } label: {
                                        Text("Delete")
                                    }
                                }

                            }
                        }
                        //MARK: Rearrange Task
                        .onMove {source, dest in
                            taskVM.reArrangeTask(fromIndex: source, toIndex: dest)
                            print("UPdate")
                            print(source)
                            print(dest)
                        }
                        //MARK: Delete Task
                        .alert("Delete Task", isPresented: $showDeleteAlert, actions: {
                            Button(role: .destructive) {
                                print("Delete")
                                showDeleteAlert = false
                                taskVM.removeTask(task: selectedTask!)
                            } label: {
                                Text("Delete").textCase(.none)
                            }
                            Button(role: .cancel) {
                                print("Cancel")
                            } label: {
                                Text("Cancel").textCase(.none)
                            }

                        }, message: {
                            Text("This task will be deleted permanently").textCase(.none)
                        })

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
                            AddTaskSheet(taskVM: taskVM, learning: learning).environmentObject(learningVM)
                        }.isHidden(learningCompleted)
                        
                    }
                }.listRowBackground(taskVM.taskList.count > 0 ? Color.white : Color.clear)
            }
            
            
            //MARK: Edit Button
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton().isHidden(learningCompleted)
                }
            }.environment(\.editMode, $editMode)
            .navigationTitle("\(learning.wrappedTitle)")


        }
        //MARK: Completion Page
        .background{
            NavigationLink(destination: CompletionView(learning: learning).navigationBarHidden(true).navigationBarBackButtonHidden(true).environmentObject(learningVM), isActive: $taskVM.goalCompleted) {
                
            }
        }
        .background(Color(uiColor: UIColor.systemGray5))
        .onAppear{
            UIAppearanceHelper.setupNavigationTitle(withColor: .white)
            print("EditMODE: \(editMode)")
            taskVM.currentLearning(learning: learning)
            taskVM.fetchTasks()
        }
        .accentColor(Color(Theme.accentColor.rawValue))
        .onDisappear{
            learningVM.updateLearningGoal(learning: learning, newGoal: goalDescription)
            learningVM.updateLearningTask(learning: learning, taskList: taskVM.taskList)
        }
    }
}

struct LearningDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LearningDetailView(learning: LearningEntity(),goalDescription: "Goal").navigationTitle("CoreData")
        }
    }
}
