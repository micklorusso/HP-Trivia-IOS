//
//  CelebrationScreen.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct CelebrationScreen: View {
    @State var tappedCorrectAnswer = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                VStack {
                    if tappedCorrectAnswer {
                        Text("5")
                            .font(.largeTitle)
                            .transition(.offset(y: -geo.size.height / 2))
                    }
                }.animation(.easeOut(duration: 1).delay(0.8), value: tappedCorrectAnswer)
                Spacer()
                VStack {
                    if tappedCorrectAnswer {
                        Text("Brilliant!")
                            .font(.custom(Constants.hpFont, size: 100))
                            .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                    }
                }.animation(.easeOut(duration: 1).delay(0.5), value: tappedCorrectAnswer)
                Spacer()
                Text("Answer 1")
                    .padding()
                    .padding(.vertical)
                    .frame(width: geo.size.width * 0.8, height: 150)
                    .background(
                        .green.mix(
                            with: .black, by: 0.25)
                    )
                    .clipShape(.rect(cornerRadius: 30))
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .transition(.scale(scale: 0))
                Spacer()
                VStack {
                    if tappedCorrectAnswer {
                        Button {
                            
                        } label: {
                            Text("Next Level >")
                                .foregroundStyle(.white)
                                .font(.title)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .transition(.offset(y: geo.size.height / 2))
                    }
                }.animation(.easeOut(duration: 1).delay(1), value: tappedCorrectAnswer)
                Spacer()
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
            tappedCorrectAnswer = true
        }
    }
}

#Preview {
    CelebrationScreen()
}
