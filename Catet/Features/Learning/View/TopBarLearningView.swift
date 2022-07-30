//
//  AddLearningView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

struct TopBarLearningView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var learningViewModel: LearningViewModel
    @State var showAddAlert = false
    @State var learningTitle = ""
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.green)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/4, alignment: .top)
            HStack{
                VStack(alignment: .leading){
                    Text("Hello")
                        .bold()
                        .font(.system(size: 17))
                        .padding(.bottom, 1)
                        .padding(.top, 2)
                    Text("What do you want to learn?")
                        .bold()
                        .font(.system(size: 17))
                    Button {
                        DispatchQueue.main.async {
                            showAddAlert.toggle()
                        }
                    } label: {
                        Label("Add Learning", systemImage: "plus")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .padding()
                            .background(.white)
                            .foregroundColor(Color(red: 0.40, green: 0.44, blue: 0.87))
                            .cornerRadius(10)
                    }
                }.padding(.leading, 16)
                    .padding(.top, 60)
                Spacer()
            }
        }.padding(.top, -(UIScreen.main.bounds.size.height/15))
            .background(
                
                AlertControllerView(learningViewModel: learningViewModel, learningTitleTextField: $learningTitle, showAlert: $showAddAlert, alertTitle: "Add learning", alertMessage: "What do you want to learn?",alertMode: alertMode.add, learning: nil)
                
            )
    }
}

struct AddLearningView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarLearningView().environmentObject(LearningViewModel())
    }
}
