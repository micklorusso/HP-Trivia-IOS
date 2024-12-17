//
//  QuestionsScreen.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI
import AVKit

struct QuestionsScreen: View {
    @State private var hintWiggle = false
    @State private var animationTimer: Timer?
    @State private var revealHint = false
    @State private var revealBook = false
    @Binding var tappedCorrectAnswer: Bool
    @State var wrongAnswersTapped: [Int] = []
    @State private var soundEffectsPlayer: AVAudioPlayer!
    
    let answers: [Bool]
    var namespace: Namespace.ID
    var geometryID: String
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    VStack {
                        if animateViewsIn {
                            Text("Who is Herry Potter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .transition(.scale(scale: 0))
                        }
                    }.animation(
                        .easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1 : 0), value: animateViewsIn)
                    Spacer()
                    
                    HStack {
                        VStack {
                            if animateViewsIn {
                                Button {
                                    revealHint = true
                                    playFlipSound()
                                } label: {
                                    Image(
                                        systemName: "questionmark.square.fill"
                                    )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .padding(.leading, 30)
                                    .transition(.offset(x: -geo.size.width / 2))
                                    .rotationEffect(
                                        .degrees(hintWiggle ? -13 : -17)
                                    )
                                    .rotationEffect(
                                        .degrees(revealHint ? 1440 : 0)
                                    )
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .offset(x: revealHint ? geo.size.width : 0)
                                    .opacity(revealHint ? 0 : 1)
                                    .overlay(content: {
                                        Text("The Boy Who _____")
                                            .font(.title)
                                            .padding(.leading, 30)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .opacity(revealHint ? 1 : 0)
                                    })
                                    .animation(
                                        .easeInOut(duration: 1),
                                        value: revealHint
                                    )
                                    .animation(
                                        .easeInOut(duration: 0.1).repeatCount(
                                            9), value: hintWiggle
                                    )
                                    .onAppear {
                                        animationTimer = Timer.scheduledTimer(
                                            withTimeInterval: 10, repeats: true
                                        ) { _ in
                                            hintWiggle.toggle()
                                        }
                                    }
                                }
                            }
                        }.animation(
                            .easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 2.3 : 0),
                            value: animateViewsIn)
                        
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    revealBook = true
                                    playFlipSound()
                                } label: {
                                    Image(systemName: "book.closed")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                        .foregroundStyle(.black)
                                        .frame(width: 100, height: 100)
                                        .background(.cyan)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .padding(.trailing, 30)
                                        .transition(
                                            .offset(x: geo.size.width / 2)
                                        )
                                        .rotationEffect(
                                            .degrees(hintWiggle ? 13 : 17)
                                        )
                                        .rotationEffect(
                                            .degrees(revealBook ? 1440 : 0)
                                        )
                                        .scaleEffect(revealBook ? 5 : 1)
                                        .offset(
                                            x: revealBook ? -geo.size.width : 0
                                        )
                                        .opacity(revealBook ? 0 : 1)
                                        .overlay(content: {
                                            Image("hp1")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150).padding(
                                                    .trailing, 30
                                                )
                                                .opacity(revealBook ? 1 : 0)
                                        })
                                        .animation(
                                            .easeInOut(duration: 0.1)
                                            .repeatCount(9),
                                            value: hintWiggle
                                        )
                                        .animation(
                                            .easeInOut(duration: 1),
                                            value: revealBook)
                                }
                            }
                        }
                        .animation(
                            .easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 2.3 : 0),
                            value: animateViewsIn)
                    }.frame(width: geo.size.width)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<4) { i in
                            VStack {
                                if animateViewsIn {
                                    
                                    if answers[i] == true {
                                        Text("Answer \(i)")
                                            .padding()
                                            .padding(.vertical)
                                            .frame(width: geo.size.width / 2.2)
                                            .background(
                                                .green.opacity(0.5)
                                            )
                                            .clipShape(.rect(cornerRadius: 30))
                                            .font(.title3)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .transition(.scale(scale: 0))
                                            .matchedGeometryEffect(
                                                id: geometryID, in: namespace)
                                            .onTapGesture {
                                                playCorrectSound()
                                                withAnimation(.easeOut(duration: 1)) {
                                                    tappedCorrectAnswer = true
                                                    animateViewsIn = false
                                                }
                                            }
                                    } else {
                                        Text("Answer \(i)")
                                            .padding()
                                            .padding(.vertical)
                                            .frame(width: geo.size.width / 2.2)
                                            .background(wrongAnswersTapped.contains(i) ? .red.opacity(0.5) : .green.opacity(0.5))
                                            .clipShape(.rect(cornerRadius: 30))
                                            .font(.title3)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .transition(.scale(scale: 0))
                                            .scaleEffect(wrongAnswersTapped.contains(i) ? 0.8 : 1)
                                            .onTapGesture {
                                                giveWrongFeedback()
                                                playWrongSound()
                                                withAnimation(.easeOut(duration: 1)) {
                                                    wrongAnswersTapped.append(i)
                                                }
                                            }
                                            .disabled(wrongAnswersTapped.contains(i))
                                    }
                                    
                                }
                            }.animation(
                                .easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1.5 : 0),
                                value: animateViewsIn)
                            
                        }
                        
                    }.frame(width: geo.size.width)
                        .padding(.top, 30)
                    Spacer()
                }
            }.frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
        }
    }
    
    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        soundEffectsPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        soundEffectsPlayer.play()
    }
    
    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        soundEffectsPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        soundEffectsPlayer.play()
    }
    
    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        soundEffectsPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        soundEffectsPlayer.play()
    }
    
    private func giveWrongFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    @Previewable @State var tappedCorrectAnswer = true
    @Previewable @State var animateViewsIn = true
    QuestionsScreen(
        tappedCorrectAnswer: $tappedCorrectAnswer,
        answers: [true, false, false, false], namespace: namespace,
        geometryID: "correctAnswer", animateViewsIn: $animateViewsIn)
}
