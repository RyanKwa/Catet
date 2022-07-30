//
//  LoadingView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import SwiftUI

struct LoadingView: View {
    @State var showAnimation = false
    var body: some View {
        VStack{
            Text("😻")
                .font(.system(size: 60))
                .scaleEffect(1.1)
                .animation(
                    .spring(response: 0.2, dampingFraction: 0.3, blendDuration: 1).repeatForever(autoreverses: true),
                    value: showAnimation)
//            ProgressView()
        }.onAppear{
            showAnimation.toggle()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
