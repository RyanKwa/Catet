//
//  TaskView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct TaskView: View {
    @State var taskCompleted = false
    var body: some View {
        HStack {
            ZStack{
                Button {
                    print("Checklist")
                    taskCompleted.toggle()
                } label: {
                    if taskCompleted {
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(Theme.accentColor.rawValue))
                    }
                    else{
                        Image(systemName: "square")
                            .font(.system(size: 24))
                            .foregroundColor(Color(Theme.accentColor.rawValue))
                    }
                }.buttonStyle(PlainButtonStyle())
                .padding(.trailing, 5)
            }
            VStack(alignment: .leading){
                Spacer()
                Text("Learn CoreData concept")
                Spacer()
                Text("22/07/2022 07:00 PM")
                Spacer()
            }
            Spacer()
            
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .previewLayout(.fixed(width: UIScreen.main.bounds.size.width, height: 54))
    }
}
