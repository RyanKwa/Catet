//
//  MainView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var appState: AppState
    var learningVM = LearningViewModel()
    var body: some View {
        NavigationView{
            TabView{
                
                LearningView().tabItem {
                    Label("Learning", systemImage: "book.fill")
                }.navigationBarHidden(true).environmentObject(learningVM).environmentObject(appState)
                
                CatGalleryView().tabItem {
                    Label("Cat Gallery", systemImage: "pawprint.fill")
                }.navigationTitle("Cat Gallery").navigationBarTitleDisplayMode(.large).navigationBarHidden(false)
                
            }
            .accentColor(Color(Theme.accentColor.rawValue))
            .onAppear{
                //                UITabBar.appearance().isTranslucent = false
                UITabBar.appearance().backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.94)
                NotificationManager.instance.requestNotificationAuthoriziation()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
