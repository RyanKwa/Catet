//
//  EmptyStateView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 28/07/22.
//

import SwiftUI
enum EmptyState: String{
    case learning
    case task
    case catGallery
}
struct EmptyStateView: View {
    var emptyStateFor: EmptyState
    var body: some View {
        VStack(alignment: .center){
            if emptyStateFor == .learning {
                Image("EmptyLearning")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                Group{
                    Text("There are no learning right now")
                    Text("How about add a new one?")
                }.foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.6))
            }
            else if emptyStateFor == .task {
                Image("EmptyTask")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                Group{
                    Text("Looks like you currently have no tasks")
                    Text("How about add some tasks to achieve your goal?")
                }
                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.6))
            }
            else if emptyStateFor == .catGallery{
                Image("EmptyCatGallery")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                Group{
                    Text("The Cat Gallery is empty right now")
                    Text("Try finish your learning first!")
                }
                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.6))
            }
        }.background(Color.clear)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(emptyStateFor: EmptyState.task)
    }
}
