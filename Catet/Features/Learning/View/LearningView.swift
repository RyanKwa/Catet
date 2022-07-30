//
//  LearningView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

struct LearningView: View {
    @EnvironmentObject var appState: AppState
    
    @EnvironmentObject var learningVM: LearningViewModel
    @State private var selectedItem: UUID? = nil
    @State var showAddAlert = false
    @State var showRenameAlert = false
    @State var showDeleteAlert = false
    
    @State var selectedLearning: LearningEntity? = nil
    @State var learningTitle = ""
    @State var isActiveView = true
    var body: some View {
        VStack{
            TopBarLearningView().environmentObject(learningVM)
            if learningVM.onGoingLearning.count == 0 && learningVM.completedLearning.count == 0 {
                Spacer()
                EmptyStateView(emptyStateFor: .learning).background(Color.clear)
                Spacer()
            }
            else if learningVM.onGoingLearning.count > 0 || learningVM.completedLearning.count > 0 {
                
                List{
                    //MARK: Ongoing Learning
                    Section {
                        ForEach(Array(learningVM.onGoingLearning.enumerated()), id: \.offset) { index, ongoing in
                            ZStack{
                                
                                NavigationLink(destination: LearningDetailView(learning: ongoing,goalDescription: ongoing.wrappedGoal)
                                    .accentColor(Color(Theme.accentColor.rawValue))
                                    .environmentObject(learningVM), tag: ongoing.wrappedId, selection: $selectedItem) {
                                    }
                                    .isDetailLink(false)
                                    .navigationTitle("Learning")
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                HStack(){
                                    LearningCardView(learningTitle: ongoing.wrappedTitle, learningGoal: ongoing.wrappedGoal, task: ongoing.wrappedTasks).environmentObject(learningVM)
                                    Spacer()
                                }
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    print("Delete")
                                    showDeleteAlert.toggle()
                                    selectedLearning = ongoing
                                } label: {
                                    Text("Delete")
                                }
                                Button {
                                    print("Rename")
                                    showRenameAlert.toggle()
                                    selectedLearning = ongoing
                                    learningTitle = ongoing.wrappedTitle
                                } label: {
                                    Text("Rename")
                                }.tint(Color(Theme.accentColor.rawValue))
                            }
                            .listRowBackground(index % 2 == 0 ? Color(Theme.pastelorange.rawValue) : Color(Theme.lightorange.rawValue))
                        }
                        
                    } header: {
                        Text("Ongoing")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.leading, -20)
                            .padding(.bottom, 3)
                            .textCase(.none)
                    }
                    .alert("Delete Learning", isPresented: $showDeleteAlert, actions: {
                        Button(role: .destructive) {
                            print("Delete")
                            showDeleteAlert = false
                            learningVM.deleteLearning(learning: selectedLearning!)
                            
                        } label: {
                            Text("Delete").textCase(.none)
                        }
                        Button(role: .cancel) {
                            print("Cancel")
                        } label: {
                            Text("Cancel").textCase(.none)
                        }
                        
                    }, message: {
                        Text("This learning and all the notes inside will be deleted permanently").textCase(.none)
                    })
                    
                    Section {
                        //MARK: Completed Learning
                        ForEach(Array(learningVM.completedLearning.enumerated()), id: \.offset) { index, completed in
                            ZStack{
                                NavigationLink(destination: LearningDetailView(learning: completed, goalDescription: completed.wrappedGoal)            .accentColor(Color(Theme.accentColor.rawValue)).environmentObject(learningVM), tag: completed.wrappedId, selection: $selectedItem) {
                                    
                                    }
                                    .isDetailLink(false)
                                    .navigationTitle("Learning")
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                HStack{
                                    LearningCardView(learningTitle: completed.wrappedTitle, learningGoal: completed.wrappedGoal, task: completed.wrappedTasks).environmentObject(learningVM)
                                    Spacer()
                                }
                            }
                            .swipeActions(allowsFullSwipe: false){
                                Button(role: .destructive) {
                                    print("Delete")
                                    showDeleteAlert.toggle()
                                    selectedLearning = completed
                                } label: {
                                    Text("Delete")
                                }
                                
                            }
                            .listRowBackground(index % 2 == 0 ? Color(Theme.pastelgreen.rawValue) : Color(Theme.lightgreen.rawValue))
                        }
                        
                    } header: {
                        Text("Completed")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.leading, -20)
                            .padding(.bottom, 3)
                            .textCase(.none)
                    }
                }
                
            }
            
//            Button {
//                learningVM.deleteAllData()
//            } label: {
//                Text("Delete ALL")
//            }
        }.onAppear{
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            self.learningVM.fetchcompletedLearning()
            self.learningVM.fetchOnGoingLearning()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color(uiColor: UIColor.systemGray5))
        //MARK: Pop to Root
        .onReceive(appState.$backToLearning) { backToLearning in
            if backToLearning{
                //                self.isActiveView = false
                self.selectedItem = UUID()
                self.appState.backToLearning = false
            }
        }
        .background(
            AlertControllerView(learningViewModel: learningVM, learningTitleTextField: $learningTitle, showAlert: $showRenameAlert, alertTitle: "Rename Learning", alertMessage: "",alertMode: .edit, learning: selectedLearning)
        )
        
    }
    
}

struct LearningView_Previews: PreviewProvider {
    static var learningVM = LearningViewModel()
    static var appState = AppState()
    static var previews: some View {
        LearningView().environmentObject(appState).environmentObject(learningVM)
    }
}

