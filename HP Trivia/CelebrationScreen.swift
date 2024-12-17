//
//  CelebrationScreen.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct CelebrationScreen: View {
    @State var scaleButton = false
    @State var moveScore = false
    @State var animationFinished = false
    
    var namespace: Namespace.ID
    var geometryID: String
    @Binding var tappedCorrectAnswer: Bool
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                VStack {
                    if tappedCorrectAnswer {
                        Text("5")
                            .font(.largeTitle)
                            .transition(.offset(y: -geo.size.height / 2))
                            .offset(x: moveScore ? geo.size.width / 2 : 0, y: moveScore ? -geo.size.height / 6 : 0)
                            .opacity(moveScore ? 0 : 1)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1).delay(1.8)) {
                                    moveScore.toggle()
                                }
                            }
                    }
                }.animation(.easeOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 0.8 : 0), value: tappedCorrectAnswer)
                Spacer()
                VStack {
                    if tappedCorrectAnswer {
                        Text("Brilliant!")
                            .font(.custom(Constants.hpFont, size: 100))
                            .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                    }
                }.animation(.easeOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 0.5 : 0), value: tappedCorrectAnswer)
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
                    .matchedGeometryEffect(id: geometryID, in: namespace)
                Spacer()
                VStack {
                    if tappedCorrectAnswer {
                        Button {
                            tappedCorrectAnswer = false
                        } label: {
                            Text("Next Level >")
                                .foregroundStyle(.white)
                                .font(.title)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .scaleEffect(scaleButton ? 1.2 : 1)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                scaleButton.toggle()
                            }
                        }
                        .transition(.offset(y: geo.size.height / 2))
                        .disabled(!animationFinished)
                    }
                }.animation(.easeOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 1 : 0), value: tappedCorrectAnswer)
                Spacer()
                Spacer()
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                animationFinished = true
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var tappedCorrectAnswer = true
    CelebrationScreen(namespace: namespace, geometryID: "correctAnswer", tappedCorrectAnswer: $tappedCorrectAnswer)
}
