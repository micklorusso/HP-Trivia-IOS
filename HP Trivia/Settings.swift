//
//  Settings.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    
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
                            if store.books[i] == .active || (store.books[i] == .locked && store.purchasedProductIDs.contains("hp\(i+1)")) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(systemName: "checkmark.circle.fill").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                        .shadow(radius: 3)
                                }.onTapGesture {
                                    store.books[i] = .inactive
                                }
                                .task {
                                    store.books[i] = .active
                                }
                            } else if store.books[i] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit().overlay(.black.opacity(0.33))
                                    
                                    Image(systemName: "circle").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.green)
                                        .padding(2)
                                        .shadow(radius: 3)
                                }.onTapGesture {
                                    store.books[i] = .active
                                }
                            } else if store.books[i] == .locked {
                                ZStack {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit().overlay(.black.opacity(0.66))
                                    
                                    Image(systemName: "lock.fill").font(.largeTitle).imageScale(.large)
                                        .foregroundStyle(.black)
                                        .shadow(color: .white, radius: 3)
                                }.onTapGesture {
                                    Task {
                                        await store.purchaseProduct(store.products[i-3])
                                    }
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
            }.foregroundStyle(.black)
        }
    }
}

#Preview {
    Settings()
        .environmentObject(Store())
}
