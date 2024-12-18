//
//  ContentView.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 13/12/24.
//

import AVKit
import SwiftUI

struct ContentView: View {
    var isPreview: Bool
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var gameViewModel: GameViewModel
    @State private var audioPlayer: AVAudioPlayer!
    @State var scaleButton = false
    @State var moveBackgroundImage = false
    @State var animateViewsIn = false
    @State var showInstructions = false
    @State var showSettings = false
    @State var showGameplay = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(
                        width: geo.size.width * 3,
                        height: geo.size.height * 1.2
                    )
                    .padding(.top)
                    .offset(
                        x: moveBackgroundImage
                            ? geo.size.width / 1.1 : -geo.size.width / 1.1
                    )
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }

                VStack {

                    VStack {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                Text("HP")
                                    .font(.custom(Constants.hpFont, size: 80))

                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                                    .padding(.top, -70)
                            }.transition(.offset(y: -geo.size.height / 3))
                        }
                    }.animation(
                        .easeOut(duration: 0.7).delay(2), value: animateViewsIn)

                    Spacer()

                    VStack {
                        if animateViewsIn {
                            VStack {
                                Text("Recent Scores:")
                                Text("\(gameViewModel.recentScores[0])")
                                Text("\(gameViewModel.recentScores[1])")
                                Text("\(gameViewModel.recentScores[2])")
                            }
                            .padding()
                            .background(.black.opacity(0.5))
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .transition(.opacity)
                        }
                    }.animation(
                        .linear(duration: 1).delay(4), value: animateViewsIn)

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    showInstructions = true
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .transition(
                                            .offset(x: -geo.size.width / 3))
                                }
                            }
                        }.animation(
                            .easeOut(duration: 0.7).delay(2.7),
                            value: animateViewsIn)

                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Button {
                                    filterQuestions()
                                    gameViewModel.startGame()
                                    showGameplay = true
                                } label: {
                                    Text("Play")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 5)
                                        .background(
                                            store.books.contains(.active)
                                                ? .brown : .gray
                                        )
                                        .cornerRadius(7)
                                }
                                .scaleEffect(scaleButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(
                                        .easeInOut(duration: 1).repeatForever()
                                    ) {
                                        scaleButton.toggle()
                                    }
                                }.transition(.offset(y: geo.size.height / 3))
                                .disabled(!store.books.contains(.active))
                            }
                        }.animation(
                            .easeOut(duration: 0.7).delay(2),
                            value: animateViewsIn)

                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    showSettings = true
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .transition(
                                            .offset(x: geo.size.width / 3))
                                }
                            }
                        }.animation(
                            .easeOut(duration: 0.7).delay(2.7),
                            value: animateViewsIn)
                        Spacer()
                    }.frame(width: geo.size.width)
                        .foregroundStyle(.white)

                    if !store.books.contains(.active) {
                        Text("No questions available. Go to settings. ⬆️").foregroundStyle(.white)
                    }
                    Spacer()
                }.frame(height: geo.size.height)
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
            if !isPreview{
                playAudio()
            }
            animateViewsIn = true
        }
        .sheet(isPresented: $showInstructions) {
            Instructions()
        }
        .sheet(isPresented: $showSettings) {
            Settings()
                .environmentObject(store)
        }
        .fullScreenCover(isPresented: $showGameplay) {
            Gameplay(isPreview: false)
                .environmentObject(gameViewModel)
                .onAppear {
                    audioPlayer?.setVolume(0, fadeDuration: 2)
                }
                .onDisappear {
                    audioPlayer?.setVolume(1, fadeDuration: 3)
                }
        }

    }

    func playAudio() {
        let sound = Bundle.main.path(
            forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }

    private func filterQuestions() {
        var books: [Int] = []
        for (i, bookStatus) in store.books.enumerated() {
            if bookStatus == .active {
                books.append(i + 1)
            }
        }

        gameViewModel.filterQuestions(from: books)
    }
}

#Preview {
    ContentView(isPreview: true)
        .environmentObject(Store())
        .environmentObject(GameViewModel())
}
