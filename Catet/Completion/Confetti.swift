//
//  Confetti.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct Confetti: View {
    @State var confetti = 10
    @State var leftSideWidth = Int(UIScreen.main.bounds.width/20)
    @State var height: Int
    @State var rightSideWidth = Int(UIScreen.main.bounds.width/3)
//    var rightSideHeight: Int {
//        return leftSideHeight
//    }
//
    @State var colors = [Color(Theme.lightgreen.rawValue), Color(Theme.lightorange.rawValue), Color(Theme.accentColor.rawValue)]
    var body: some View {
        HStack{
        ForEach(0...7, id:\.self) { num in
            if num % 2 == 1{
                Rectangle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(colors.randomElement())
                    .rotationEffect(.degrees(45))
                    .position(x: CGFloat(Int.random(in: leftSideWidth...leftSideWidth+8)), y: CGFloat(Int.random(in: height-80...height)))
            }
            else{
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(colors.randomElement())
                    .rotationEffect(Angle(degrees: 45))
                    .position(x: CGFloat(Int.random(in: leftSideWidth...leftSideWidth+10)), y: CGFloat(Int.random(in: height-80...height)))
            }
        }
//            Rectangle()
//                .frame(width: 10, height: 10)
//                .foregroundColor(colors.randomElement())
//                .rotationEffect(.degrees(45))
//                //MARK: y bound di height/2 ke height/2 - 90
//                //MARK: y bound di height/2 - 90
            
//                //MARK: left x bound di width/10 ke width/20 + 100
//                .position(x: UIScreen.main.bounds.width/20 + 100, y: UIScreen.main.bounds.height/2)
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(Color(Theme.lightgreen.rawValue))
//                .opacity(0.2)
            ForEach(0...7, id:\.self) { num in
                if num % 2 == 1{
                    Rectangle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(colors.randomElement())
                        .rotationEffect(.degrees(45))
                        .position(x: CGFloat(Int.random(in: rightSideWidth-150...rightSideWidth-140)), y: CGFloat(Int.random(in: height-80...height)))
                }
                else{
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(colors.randomElement())
                        .rotationEffect(Angle(degrees: 45))
                        .position(x: CGFloat(Int.random(in: rightSideWidth-130...rightSideWidth-120)), y: CGFloat(Int.random(in: height-80...height)))
                }
            }

//            Rectangle()
//                .frame(width: 10, height: 10)
//                .foregroundColor(colors.randomElement())
//                .rotationEffect(.degrees(45))
//                //MARK: right x bound di width/3 - 20 ke width/3 - 100
//                .position(x: UIScreen.main.bounds.width/3 - 20, y: UIScreen.main.bounds.height/2)

        }
    }
}

struct Confetti_Previews: PreviewProvider {
    static var previews: some View {
        Confetti(height: Int(UIScreen.main.bounds.height/5))
    }
}
