//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import AVKit
import SwiftUI

struct Gameplay: View {
    var isPreview: Bool

    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var gameViewModel: GameViewModel

    @Namespace private var namespace

    @State private var tappedCorrectAnswer = false
    @State private var animateViewsIn = false

    @State private var musicPlayer: AVAudioPlayer!

    let geometryID = "correctAnswer"

    let tempAnswers = [true, false, false, false]

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
                    .overlay(.black.opacity(0.75))

                VStack {
                    HStack {
                        Button {
                            gameViewModel.endGame()
                            dismiss()
                        } label: {
                            Text("End Game")
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(.red)
                                .cornerRadius(10)
                                .opacity(0.75)
                        }.padding(.leading)

                        Spacer()

                        Text("Score: \(gameViewModel.gameScore)")
                            .padding(.trailing)
                    }
                    .frame(width: geo.size.width)
                    .font(.title3)
                    .padding(.top, 50)
                    .padding(.bottom, 30)

                    if tappedCorrectAnswer {
                        CelebrationScreen(
                            namespace: namespace, geometryID: geometryID,
                            tappedCorrectAnswer: $tappedCorrectAnswer
                        ).frame(
                            width: geo.size.width, height: geo.size.height
                        )
                        .environmentObject(gameViewModel)
                    } else {
                        QuestionsScreen(
                            tappedCorrectAnswer: $tappedCorrectAnswer,
                            namespace: namespace, geometryID: geometryID,
                            animateViewsIn: $animateViewsIn
                        ).frame(
                            width: geo.size.width, height: geo.size.height
                        ).onAppear {
                            animateViewsIn = true
                        }
                        .environmentObject(gameViewModel)
                    }
                }.foregroundStyle(.white)

            }.frame(width: geo.size.width, height: geo.size.height)

        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if !isPreview {
                    playMusic()
                }
            }
        }
    }

    func playMusic() {
        let songs = [
            "let-the-mystery-unfold", "spellcraft",
            "hiding-place-in-the-forest", "deep-in-the-dell",
        ]
        let i = Int.random(in: 0...3)
        let sound = Bundle.main.path(forResource: songs[i], ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.1
        musicPlayer.play()
    }

}

#Preview {
    Gameplay(isPreview: true)
        .environmentObject(GameViewModel())
}
