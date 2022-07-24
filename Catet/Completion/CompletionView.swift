//
//  CompletionView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct CompletionView: View {
    @State var confetti = 20
    @State var isActive = false
//    @State var scale = 1.0
    @State var showAnimation = false
    var body: some View {
        NavigationView {
            VStack{
                    Group{
                        Spacer().frame(height: UIScreen.main.bounds.height/20)
                        Text("Congratulations!")
                            .font(.system(size: 48.0))
                            .padding(.bottom, 30)
                            .animation(nil, value: UUID())
                        if showAnimation {
                            Confetti(height: Int(UIScreen.main.bounds.height/6))
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
        //                        .transition()

                        }
                        Text("You just finished")
                            .font(.system(size: 30.0))
                            .padding()
                            .animation(nil, value: UUID())

                        Text("Core Data")
                            .font(.system(size: 30.0))
                            .animation(nil, value: UUID())

                        Spacer()

                    }
                    HStack{
                        Spacer()
                        Button {
                            print("Next Button")
                            isActive = true
                        } label: {
                            HStack{
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(Theme.accentColor.rawValue))
                        .cornerRadius(10.0)
                        NavigationLink(destination:RewardView(),isActive: $isActive) {
                            
                        }
                    }.padding()
                    
                }.onAppear{
                    DispatchQueue.main.async {
                        withAnimation(.linear(duration: 1.0)){
                            showAnimation.toggle()
                        }

                    }
            }
        }.navigationBarHidden(true)
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
    }
}
