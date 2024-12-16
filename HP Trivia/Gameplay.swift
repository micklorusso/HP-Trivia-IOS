//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 16/12/24.
//

import SwiftUI

struct Gameplay: View {
    @Environment(\.dismiss) private var dismiss

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

                        Text("Score: 33")
                            .padding(.trailing)
                    }
                    .frame(width: geo.size.width)
                    .font(.title3)
                    .padding(.top, 50)
                    .padding(.bottom, 30)
//                    QuestionsScreen().frame(
//                        width: geo.size.width, height: geo.size.height)
                    
                    CelebrationScreen().frame(
                        width: geo.size.width, height: geo.size.height)
                }.foregroundStyle(.white)

            }.frame(width: geo.size.width, height: geo.size.height)

        }
    }
}

#Preview {
    Gameplay()
}
