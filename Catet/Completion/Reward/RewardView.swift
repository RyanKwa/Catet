//
//  RewardView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct RewardView: View {
    @EnvironmentObject var appState: AppState
    @State var learning: LearningEntity
    @EnvironmentObject var learningVM: LearningViewModel
    @State var saveToCatGallery = false
    @StateObject var imageLoader: ImageLoader
    @StateObject var catGalleyVM = CatGalleryViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            Text("As a reward here is a cat photo for you 😸")
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipped()
                    .padding(.bottom, 30)
            }
            else {
                VStack{
                    LoadingView().padding(30)
                }
            }
            Button{
                print("Bookmark")
                saveToCatGallery.toggle()
            }label: {
                Image(systemName: saveToCatGallery ? "heart.fill" : "heart")
                    .font(.system(size: 40))
                    .tint(Color(Theme.accentColor.rawValue))
                    .scaleEffect(saveToCatGallery ? 1.2 : 1)
                    .animation(.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 0), value: saveToCatGallery)

            }
            Spacer()

            Button{
                print("Continue")
                if saveToCatGallery {
                    catGalleyVM.addCatGallery(catGallery: CatGallery(url: imageLoader.url, dateFinished: Date(), goalCompleted: learning.title))
                }
                learningVM.updateLearningStatus(learning: learning)
                appState.backToLearning = true
            }label: {
                Text("Continue")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width/1.5, alignment: .center)
            }
            .tint(Color(Theme.accentColor.rawValue))
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)

        }.navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
//            catGalleryVM.fetchCatFromAPI()
        }
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView(learning: LearningEntity(), imageLoader: ImageLoader(url: ""), catGalleyVM: CatGalleryViewModel())
    }
}
