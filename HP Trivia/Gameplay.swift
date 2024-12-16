//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct Gameplay: View {
    @Environment(\.dismiss) private var dismiss
    @State var animateViewsIn = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3,
                           height: geo.size.height * 1.2)
                    .padding(.top)
                    .overlay(.black.opacity(0.75))
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("End Game")
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(.red)
                                .cornerRadius(10)
                                .opacity(0.75)
                        }                    .padding(.leading)
                        
                        Spacer()
                        
                        Text("Score: 33")
                            .padding(.trailing)
                    }
                    .frame(width: geo.size.width)
                    .font(.title3)
                    
                    VStack {
                        if animateViewsIn {
                            Text("Who is Herry Potter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .transition(.scale(scale: 0))
                        }
                    }.animation(.easeOut(duration: 1).delay(1), value: animateViewsIn)
                    Spacer()
                    
                    HStack {
                        VStack {
                            if animateViewsIn {
                                Image(systemName: "questionmark.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(-15))
                                    .padding(.leading, 30)
                                    .transition(.offset(x: -geo.size.width / 2))
                            }
                        }.animation(.easeOut(duration: 1).delay(2.3), value: animateViewsIn)
                        
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .rotationEffect(.degrees(15))
                                    .padding(.trailing, 30)
                                    .transition(.offset(x: geo.size.width / 2))
                            }
                        }.animation(.easeOut(duration: 1).delay(2.3), value: animateViewsIn)
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
                                            .background(.green.mix(with: .black, by: 0.25))
                                            .clipShape(.rect(cornerRadius: 15))
                                            .font(.title3)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .transition(.scale(scale: 0))
                                    }
                                }
                            }.animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                    
                        }
                    }.frame(width: geo.size.width)
                        .padding(.top, 30)
                    Spacer()
                }.foregroundStyle(.white)
                    .frame(height: geo.size.height)
                    
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
            animateViewsIn = true
        }
    }
}

#Preview {
    Gameplay()
}
