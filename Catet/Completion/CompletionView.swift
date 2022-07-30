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
    @State var learning: LearningEntity
    @StateObject var catGalleryVM = CatGalleryViewModel()
    @EnvironmentObject var learningVM: LearningViewModel
    var body: some View {
        NavigationView {
            VStack{
                    Group{
                        Spacer().frame(height: UIScreen.main.bounds.height/20)
                        Text("Congratulations!")
                            .font(.system(size: 48.0))
                            .padding(.bottom, 30)
                            .animation(nil, value: UUID())
                        Confetti(height: Int(UIScreen.main.bounds.height/6))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)

                        Text("You just finished")
                            .font(.system(size: 30.0))
                            .padding()
                            .animation(nil, value: UUID())

                        Text("\(learning.wrappedTitle)")
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
                        NavigationLink(destination:RewardView(learning: learning, imageLoader: ImageLoader(url: catGalleryVM.catDataFromAPI[0].url ?? ""))
                            .navigationBarHidden(true).environmentObject(learningVM),isActive: $isActive) {
                            
                        }
                    }.padding()
                    
                }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                catGalleryVM.fetchCatFromAPI()
            }
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView(learning: LearningEntity())
    }
}
