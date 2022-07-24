//
//  AddLearningView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

struct TopBarLearningView: View {
    @Environment (\.dismiss) var dismiss
    @State var showAddAlert = true
    @State var learningTitle = ""
    @State var username = ""
    @State var password = ""

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
                }.padding(.leading, 16)
                    .padding(.top, 60)
                Spacer()
            }
        }.padding(.top, -(UIScreen.main.bounds.size.height/15))
    }
}

struct AddLearningView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarLearningView()
    }
}
