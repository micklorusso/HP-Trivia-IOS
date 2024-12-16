//
//  QuestionsScreen.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct QuestionsScreen: View {
    @State private var animateViewsIn = false
    @State private var hintWiggle = false
    @State private var animationTimer: Timer?
    @State private var revealHint = false
    @State private var revealBook = false

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
                        .easeOut(duration: 1).delay(1), value: animateViewsIn)
                    Spacer()

                    HStack {
                        VStack {
                            if animateViewsIn {
                                Button {
                                    revealHint = true
                                } label: {
                                    Image(systemName: "questionmark.square.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .foregroundStyle(.cyan)
                                        .padding(.leading, 30)
                                        .transition(.offset(x: -geo.size.width / 2))
                                        .rotationEffect(
                                            .degrees(hintWiggle ? -13 : -17)
                                        )
                                        .rotationEffect(.degrees(revealHint ? 1440 : 0))
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
                                        .animation(.easeInOut(duration: 1), value: revealHint)
                                        .animation(.easeInOut(duration: 0.1).repeatCount(9), value: hintWiggle)
                                        .onAppear {
                                            animationTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                                                hintWiggle.toggle()
                                            }
                                        }
                                }
                            }
                        }.animation(
                            .easeOut(duration: 1).delay(2.3),
                            value: animateViewsIn)

                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    revealBook = true
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
                                        .transition(.offset(x: geo.size.width / 2))
                                        .rotationEffect(
                                            .degrees(hintWiggle ? 13 : 17)
                                        )
                                        .rotationEffect(.degrees(revealBook ? 1440 : 0))
                                        .scaleEffect(revealBook ? 5 : 1)
                                        .offset(x: revealBook ? -geo.size.width : 0)
                                        .opacity(revealBook ? 0 : 1)
                                        .overlay(content: {
                                            Image("hp1")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150).padding(.trailing, 30)
                                                .opacity(revealBook ? 1 : 0)
                                        })
                                        .animation(.easeInOut(duration: 0.1).repeatCount(9), value: hintWiggle)
                                        .animation(.easeInOut(duration: 1), value: revealBook)
                                }
                            }
                        }
                        .animation(
                            .easeOut(duration: 1).delay(2.3),
                            value: animateViewsIn)
                    }.frame(width: geo.size.width)

                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<4) { i in
                            VStack {
                                if animateViewsIn {
                                    Button {

                                    } label: {
                                        Text("Answer \(i)")
                                            .padding()
                                            .padding(.vertical)
                                            .frame(width: geo.size.width / 2.2)
                                            .background(
                                                .green.mix(
                                                    with: .black, by: 0.25)
                                            )
                                            .clipShape(.rect(cornerRadius: 30))
                                            .font(.title3)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .transition(.scale(scale: 0))
                                    }
                                }
                            }.animation(
                                .easeOut(duration: 1).delay(1.5),
                                value: animateViewsIn)

                        }

                    }.frame(width: geo.size.width)
                        .padding(.top, 30)
                    Spacer()
                }
            }.frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
        }.onAppear {
            animateViewsIn = true
        }
    }
}

#Preview {
    QuestionsScreen()
}
