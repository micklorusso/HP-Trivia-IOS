//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct Gameplay: View {
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
                    
                    Text("Who is Herry Potter?")
                        .font(.custom(Constants.hpFont, size: 50))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "questionmark.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(.cyan)
                            .rotationEffect(.degrees(-15))
                            .padding(.leading, 30)
                        
                        Spacer()
                        
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
                    }.frame(width: geo.size.width)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<4) { i in
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
                            }
                    
                        }
                    }.frame(width: geo.size.width)
                        .padding(.top, 30)
                    Spacer()
                }.foregroundStyle(.white)
                    .frame(height: geo.size.height)
                    
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    Gameplay()
}
