//
//  Confetti.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 23/07/22.
//

import SwiftUI

struct Confetti: View {
    @State var numberOfConfettis = 7
    @State var leftSideWidth = Int(UIScreen.main.bounds.width/20)
    @State var height: Int
    @State var rightSideWidth = Int(UIScreen.main.bounds.width/3)
    @State var onAppearShow = false
    @State var colors = [Color(Theme.lightgreen.rawValue), Color(Theme.lightorange.rawValue), Color(Theme.accentColor.rawValue)]
    var body: some View {
        HStack{
            if onAppearShow{
                //MARK: y bound di height/2 ke height/2 - 80
                //MARK: left x bound for rect di width/10 ke width/20 + 8
                //MARK: left x bound for circle di width/10 ke width/20 + 10
                ForEach(0...numberOfConfettis, id:\.self) { num in
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
                .scaleEffect(onAppearShow ? 1.1 : 1)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color(Theme.lightgreen.rawValue))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                
                //MARK: right x bound for rect di width/3 - 150(-20) ke width/3 - 140(-10)
                //MARK: right x bound for circle di width/3 - 130(-20) ke width/3 - 120(-10)
                //MARK: Y is the same
                ForEach(0...numberOfConfettis, id:\.self) { num in
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
                }.scaleEffect(onAppearShow ? 1.1 : 1)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
                
        }.onAppear{
            DispatchQueue.main.async {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0)) {
                    onAppearShow.toggle()
                }
            }
        }
    }
}

struct Confetti_Previews: PreviewProvider {
    static var previews: some View {
        Confetti(height: Int(UIScreen.main.bounds.height/5))
    }
}
