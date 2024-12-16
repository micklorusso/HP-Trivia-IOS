//
//  ContentView.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 13/12/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State var scaleButton = false
    @State var moveBackgroundImage = false
    @State var showViews = false
    @State var showInstructions = false
    @State var showSettings = false
    @State var showGameplay = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3,
                           height: geo.size.height * 1.2)
                    .padding(.top)
                    .offset(x: moveBackgroundImage ? geo.size.width / 1.1 : -geo.size.width / 1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack {
                    
                    VStack {
                        if showViews {
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
                    }.animation(.easeOut(duration: 0.7).delay(2), value: showViews)
                    
                    Spacer()
                    
                    VStack {
                        if showViews {
                            VStack {
                                Text("Recent Scores:")
                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .padding()
                            .background(.black.opacity(0.5))
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .transition(.opacity)
                        }
                    }.animation(.linear(duration: 1).delay(4), value: showViews)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            if showViews {
                                Button {
                                    showInstructions = true
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .transition(.offset(x: -geo.size.width / 3))
                                }
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2.7), value: showViews)
                        
                        Spacer()
                        VStack {
                            if showViews {
                                Button {
                                    showGameplay = true
                                } label: {
                                    Text("Play")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .padding(.horizontal, 30)
                                        .padding(.vertical, 5)
                                        .background(.brown)
                                        .cornerRadius(7)
                                }
                                .scaleEffect(scaleButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                        scaleButton.toggle()
                                    }
                                }.transition(.offset(y: geo.size.height / 3))
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2), value: showViews)
                        
                        Spacer()
                        
                        VStack {
                            if showViews {
                                Button {
                                    showSettings = true
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .transition(.offset(x: geo.size.width / 3))
                                }
                            }
                        }.animation(.easeOut(duration: 0.7).delay(2.7), value: showViews)
                        Spacer()
                    }.frame(width: geo.size.width)
                        .foregroundStyle(.white)
                    Spacer()
                }.frame(height: geo.size.height)
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
//            playAudio()
            showViews = true
        }
        .sheet(isPresented: $showInstructions) {
            Instructions()
        }
        .sheet(isPresented: $showSettings) {
            Settings()
        }
        .fullScreenCover(isPresented: $showGameplay) {
            Gameplay()
        }
     
    }
    
    func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
