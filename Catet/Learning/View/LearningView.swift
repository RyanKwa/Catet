//
//  LearningView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

struct LearningView: View {
    @State var onGoingData = ["CoreData", "Networking"]
    @State var completedData = ["MVC", "AudioFoundation"]
    @State private var onGoingIndex = 1
    @State private var completedIndex = 1
    var body: some View {
        
        VStack{

            TopBarLearningView()
            List{
                Section {
                    ForEach(Array(onGoingData.enumerated()), id: \.offset) { index, ongoing in
                        ZStack{
                            NavigationLink(destination: LearningDetailView(navigationTitle: ongoing).accentColor(Color(Theme.accentColor.rawValue))) {
                            }.navigationTitle("Learning")
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                            HStack(){
                                LearningCardView(learningTitle: "\(ongoing)", learningGoal: "Belajar", finishedTask: Int.random(in: 1...2), totalTask: Int.random(in: 3...5))
                                Spacer()
                            }
                        }.listRowBackground(index % 2 == 0 ? Color(Theme.pastelorange.rawValue) : Color(Theme.lightorange.rawValue))
//                        LearningCardView(learningTitle: "\(ongoing)", learningGoal: "Belajar", finishedTask: Int.random(in: 1...2), totalTask: Int.random(in: 3...5))                            .background(NavigationLink("", destination: LearningDetailView(navigationTitle: ongoing)))
//                            .listRowBackground(index % 2 == 0 ? Color(Theme.pastelorange.rawValue) : Color(Theme.lightorange.rawValue))
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
                Section {
                    ForEach(Array(completedData.enumerated()), id: \.offset) { index, completed in
                        ZStack{
                            NavigationLink(destination: LearningDetailView(navigationTitle: completed)            .accentColor(Color(Theme.accentColor.rawValue))) {
                                
                            }
                                .navigationTitle("Learning")
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                                .accentColor(Color(Theme.accentColor.rawValue))
                            HStack{
                                LearningCardView(learningTitle: "\(completed)", learningGoal: "Belajarin dan implementasiin", finishedTask: 5, totalTask: 5)
                                Spacer()
                            }
                        }
                        .listRowBackground(index % 2 == 0 ? Color(Theme.pastelgreen.rawValue) : Color(Theme.lightgreen.rawValue))
                        
//                        HStack{
//                            LearningCardView(learningTitle: "\(completed)", learningGoal: "Belajarin dan implementasiin", finishedTask: 5, totalTask: 5)
//                                .background(NavigationLink("", destination: LearningDetailView(navigationTitle: completed)))
//
//                        }
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
//            Button {
//                onGoingData.append("Swiftui")
//                onGoingData.append("MVVM")
//                completedData.append("Observer")
//                completedData.append("Refactor")
//            } label: {
//                Text("Add ongoing and completed")
//            }

            
        }.onAppear{
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
        .background(Color(uiColor: UIColor.systemGray5))
    }
    
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
