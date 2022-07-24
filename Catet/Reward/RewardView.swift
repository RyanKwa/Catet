//
//  RewardView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct RewardView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("As a reward here is a cat photo for you 😸")
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            Image(systemName: "square.fill")
                .frame(width: 200, height: 200, alignment: .center)
                .font(.system(size: 200))
                .padding(.bottom, 30)
            Button{
                print("Bookmark")
            }label: {
                Image(systemName: "heart")
                    .font(.system(size: 30))
            }
            Spacer()

            Button{
                print("Continue")
            }label: {
                Text("Continue")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width/1.5, alignment: .center)
            }
            .tint(Color(Theme.accentColor.rawValue))
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)

        }
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
