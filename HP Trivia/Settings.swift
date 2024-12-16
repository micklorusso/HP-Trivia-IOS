//
//  Settings.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

enum Status {
    case active
    case inactive
    case locked
}

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @State var statusList: [Status] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    
    var body: some View {
        ZStack {
            ParchmentBackground()
            VStack {
                Text("Which books would you like to see questions from?").padding()
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<7) { i in
                            if statusList[i] == .active {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(systemName: "checkmark.circle.fill").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                        .shadow(radius: 3)
                                }.onTapGesture {
                                    statusList[i] = .inactive
                                }
                                
                            } else if statusList[i] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit().overlay(.black.opacity(0.33))
                                    
                                    Image(systemName: "circle").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                        .shadow(radius: 3)
                                }.onTapGesture {
                                    statusList[i] = .active
                                }
                            } else if statusList[i] == .locked {
                                ZStack {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit().overlay(.black.opacity(0.66))
                                    
                                    Image(systemName: "lock.fill").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.black)
                                        .shadow(color: .white, radius: 3)
                                }
                            }
                        }
                    }.padding()
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }.doneButton()
            }
        }
    }
}

#Preview {
    Settings()
}
